--make_mapgen.lua
require("setup/plants")

local autoplacer =
{
    type = "autoplace-control",
    name = "JF_grow_plant",
    richness = true,
    order = "JF-a",
    category = "terrain"
}
data:extend{autoplacer}

-- local autoplacer =
-- {
--     type = "autoplace-control",
--     name = "JF_grow_resource",
--     localised_name = {"", "[entity=new-ore] ", {"entity-name.new-ore"}},
--     richness = true,
--     order = "b-a",
--     category = "resource"
-- }
-- data:extend{autoplacer}

local noiselayer =
{
    type = "noise-layer",
    name = "plants",
    order = "JF-a",
}
data:extend{noiselayer}

local noise = require("noise")
local resource_autoplace = require("resource-autoplace")

local mod = 0

for plant_name, plant_value in pairs(plants) do
    mod = mod + 100
    local pics = {}
    for _, icon in pairs(plant_value.icons) do
    pic = {
        filename = "__JFood__/assets/" ..icon.. ".png",
        height = 64,
        width = 64
    }
    table.insert(pics, pic)
    end

    local has_starting_area_placement = plant_value.starting_area
    resource_autoplace.initialize_patch_set(plant_value.name, has_starting_area_placement)

    local new_autoplace = resource_autoplace.resource_autoplace_settings({
        name = "JF_grow_plant",
        order = plant_value.order,
        base_density = plant_value.settings.size,
        has_starting_area_placement = has_starting_area_placement,
        candidate_spot_count = 100, -- 22
        base_spots_per_km2 = plant_value.settings.frequency, -- 2.5
        random_spot_size_minimum = 5, -- 0.25
        random_spot_size_maximum = 20, -- 2
        regular_blob_amplitude_multiplier = 8, -- 1
        starting_blob_amplitude_multiplier = 4, -- 1
        minimum_richness = 10, -- 0
        regular_rq_factor = 20, -- 1
        starting_rq_factor = 5, -- 1
        seed1=mod
    })

    local new_plant =
    {
        name = plant_value.name,
        type = "simple-entity",
        flags = { "placeable-neutral", "placeable-off-grid" },
        icon = "__JFood__/assets/" ..plant_value.icons[1].. ".png",
        icon_size = 64,
        subgroup = "JFood",
        order = plant_value.order,
        -- collision_box = { { -0.01, -0.01 }, { 0.01, 0.01 } },
        selection_box = { { -1.0, -1.0 }, { 1.0, 1.0 } },
        minable = {
            mining_particle = "wooden-particle",
            mining_time = 0.2,
            results = plant_value.mining,
        },
        loot = plant_value.destroy,
        map_color = plant_value.color,
        count_as_rock_for_filtered_deconstruction = true,
        --mined_sound = { filename = "__JFood__/sound/deconstruct.ogg" },
        render_layer = "object",
        max_health = plant_value.health,
        autoplace = new_autoplace,
        pictures = pics
    }
    new_plant.autoplace.probability_expression = new_plant.autoplace.probability_expression * (noise.var("moisture") - 0.3),
    data:extend{new_plant}
end

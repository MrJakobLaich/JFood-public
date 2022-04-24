--make_machines.lua

-- this is the item of the new "machine" -> move somewhere with the recipe
local new_item = {
  type = "item",
  icon = "__JFood__/assets/cropfield.png",
  icon_mipmaps = 4,
  icon_size = 64,
  name = "JFood-cropfield",
  order = "JF-ie",
  stack_size = 100,
  subgroup = "JFood",
  place_result = "JFood-cropfield"
}
data:extend{new_item}

-- this is the recipe of the new "machine" item -> move somewhere where it makes sense
local new_recipe =
{
    type = "recipe",
    name = "JFood-cropfield",
    energy_required = 1,
    ingredients = { {"wood", 1} },
    result = "JFood-cropfield",
    result_count = 1,
    subgroup = "JFood"
}
data:extend{new_recipe}

local hide_recipes = settings.startup["JFood-0-hide-framland-recipe-from-inventory"].value

-- plants that you can grow in the cropfield
local plants = {"wheat", "water-melon"}
for _, food_name in pairs(plants) do
  local new_item =
  {
      type = "recipe",
      name = food_name,
      category = "JFood",
      energy_required = 60,
      ingredients = {{food_name, 1}},
      results = {{food_name, 10}},
      subgroup = "JFood",
      hide_from_player_crafting = false
  }
  if hide_recipes then
      new_item.hide_from_player_crafting = true
  end
  data:extend{new_item}
end

-- this is the entity of the new "machine" -> move somewhere where it makes sense
-- need graphics for this
-- does this take energy? Or can you just grow shit?
-- I think it using energy shouldn't be the biggest problem...
local CraftingMachine = {
    type = "assembling-machine",
    name = "JFood-cropfield",
    -- icon = "__JFood__/assets/crafting_machine.png",
    icon = "__JFood__/assets/cropfield.png",
    icon_size = 64,
    crafting_categories = {
        "JFood",
        -- "crafting",
        -- "smelting"
    },
    crafting_speed = 1,
    energy_source = {
        type = "electric",
        buffer_capacity = "150MJ",
        usage_priority = "secondary-input",
        input_flow_limit = "150W",
        drain = "10W"
    },
    -- enabling the collision box makes it hand input / hand output stuff
    -- collision_mask = {"layer-20"}, -- what's the default collision layer for the JFood mod?
    collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
    selection_box = {{-1, -1}, {1, 1}},
    max_health = 300,
    minable = {
      mining_time = 0.2,
      result = "JFood-cropfield"
    },
    allowed_effects = {
        "speed",
        "productivity",
        "consumption",
        "pollution"
    },
    energy_usage = "100W",
    -- animation = {
    --   type = "animation",
    --   name = "JFood-crafting-machine",
    --   filename = "__JFood__/assets/cropfield.png",
    --   width = 64,
    --   height = 64
    -- }
    animation = {
      layers =
      {
        {
          filename = "__JFood__/assets/cropfield_animated.png",
          priority="high",
          width = 64,
          height = 64,
          frame_count = 20,
          line_length = 10,
          animation_speed = 0.025 --0.0625
          
          -- priority="high",
          -- width = 108,
          -- height = 114,
          -- frame_count = 32,
          -- line_length = 8,
          -- shift = util.by_pixel(0, 2),
        }
      }
    },
}

data:extend{CraftingMachine}

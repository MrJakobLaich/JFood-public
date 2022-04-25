--make_machines.lua
require("setup/machines")
require("setup/recipes_in_machines")

local hide_recipes = settings.startup["JFood-0-hide-recipes-from-inventory"].value

for machine_name, machine_value in pairs(machines) do
  -- this is the item of the new machine -> move somewhere with the recipe
  local new_item = {
    type = "item",
    name = machine_value.name,
    icon = "__JFood__/assets/"..machine_value.icon..".png",
    --icon_mipmaps = 4,
    icon_size = machine_value.icon_size,
    order = machine_value.order,
    stack_size = machine_value.stack_size,
    subgroup = "JFood",
    place_result = machine_value.place
  }
  data:extend{new_item}

  -- this is the recipe of the new machine item -> move somewhere where it makes sense
  local new_recipe =
  {
      type = "recipe",
      name = machine_value.recipe.result,
      energy_required = machine_value.recipe.time,
      ingredients = machine_value.recipe.ingredients,
      result = machine_value.recipe.result,
      result_count = machine_value.recipe.output,
      subgroup = "JFood"
  }
  data:extend{new_recipe}

  -- iterate over all recipes to be generated for the current machine
  for recipes_in_machines_name, recipes_in_machines_value in pairs(recipes_in_machines) do
    if recipes_in_machines_value.name == machine_value.name then
      local matching_recipes = recipes_in_machines_value.recipes
      for recipe_name, recipe_value in pairs(matching_recipes) do
        local new_recipe =
        {
            type = "recipe",
            name = recipe_value.name,
            category = "JFood",
            energy_required = recipe_value.energy_required,
            ingredients = recipe_value.ingredients,
            results = recipe_value.results,
            subgroup = "JFood",
            hide_from_player_crafting = false
        }
        if hide_recipes then
          new_recipe.hide_from_player_crafting = true
        end
        data:extend{new_recipe}
      end
    end
  end

  -- this is the entity of the new "machine" -> move somewhere where it makes sense
  -- need graphics for this
  -- does this take energy? Or can you just grow shit?
  -- I think it using energy shouldn't be the biggest problem...
  local new_entity = {
    type = "assembling-machine",
    name = machine_value.name,
    icon = "__JFood__/assets/"..machine_value.icon..".png",
    icon_size = machine_value.icon_size,
    crafting_categories = {
        "JFood"
    },
    crafting_speed = 1,
    energy_source = machine_value.basic_energy_information,
    energy_usage = machine_value.running_energy_cost,
    -- enabling the collision box makes it hand input / hand output stuff
    -- collision_mask = {"layer-20"}, -- what's the default collision layer for the JFood mod?
    collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
    selection_box = {{-1, -1}, {1, 1}},
    max_health = machine_value.max_health,
    minable = {
      mining_time = machine_value.mining_time,
      result = machine_value.name
    },
    allowed_effects = machine_value.module_infos.allowed_modules,
    module_specification = machine_value.module_infos.module_specification,
    animation = {
      layers =
      {
        {
          -- can this be done any other way?
          filename = "__JFood__/assets/"..machine_value.animation.filename..".png",
          priority=machine_value.animation.priority,
          width = machine_value.animation.width,
          height = machine_value.animation.height,
          frame_count = machine_value.animation.frame_count,
          line_length = machine_value.animation.line_length,
          animation_speed = machine_value.animation.animation_speed
        }
      }
    }
  }
  data:extend{new_entity}
end

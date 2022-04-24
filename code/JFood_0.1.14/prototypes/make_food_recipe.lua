-- make_recipe.lua
require("setup/recipes")

for food_name, food_value in pairs(recipes) do
    local new_item =
    {
        type = "recipe",
        name = food_value.result,
        -- category = "JFood",
        energy_required = food_value.time,
        ingredients = food_value.ingredients,
        result = food_value.result,
        result_count = food_value.output,
        subgroup = "JFood"
        -- hide_from_player_crafting = true
    }
    data:extend{new_item}
end

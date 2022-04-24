
local enable_console_output = {
    type = "bool-setting",
    name = "JFood-0-console-output",
    setting_type = "runtime-per-user",
    default_value = true
}
data:extend{enable_console_output}

local hide_farmland_recipes_from_inventory = {
    type = "bool-setting",
    name = "JFood-0-hide-framland-recipe-from-inventory",
    setting_type = "startup",
    default_value = true
}
data:extend{hide_farmland_recipes_from_inventory}

local boost_multiplier = {
    type = "double-setting",
    name = "JFood-1-crafting-multiplier",
    setting_type = "startup",
    minimum_value = 0.001,
    default_value = 1,
    maximum_value = 1000
}
data:extend{boost_multiplier}

local boost_multiplier = {
    type = "double-setting",
    name = "JFood-2-mining-multiplier",
    setting_type = "startup",
    minimum_value = 0.001,
    default_value = 1,
    maximum_value = 1000
}
data:extend{boost_multiplier}

local boost_multiplier = {
    type = "double-setting",
    name = "JFood-3-running-multiplier",
    setting_type = "startup",
    minimum_value = 0.001,
    default_value = 1,
    maximum_value = 1000
}
data:extend{boost_multiplier}

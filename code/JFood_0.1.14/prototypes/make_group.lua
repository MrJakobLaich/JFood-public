-- make_group.lua

local foodGroup =
{
    type = "item-group",
    name = "JFood",
    icon = "__JFood__/assets/bun.png",
    icon_size = 64,
    order = "JF-a"
}
data:extend{foodGroup}

local foodSubgroup =
{
    type = "item-subgroup",
    group = "JFood",
    order = "JF-a",
    name = "JFood",
}
data:extend{foodSubgroup}

local ammoCategory =
{
    type = "ammo-category",
    name = "JFood",
}
data:extend{ammoCategory}

local craftingCategory = {
    type = "recipe-category",
    name = "JFood",
    order = "JF-a"
}
data:extend{craftingCategory}

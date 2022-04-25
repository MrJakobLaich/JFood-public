--make_item.lua
require("setup/items")

for food_name, food_value in pairs(stats) do
    if food_value.boost then
        local new_food =
        {
            type = "capsule",
            name = food_value.name,
            icon = "__JFood__/assets/"..food_value.icon..".png",
            icon_size = food_value.icon_size,
            subgroup = "JFood",
            stack_size = food_value.stack_size,
            order = food_value.order,
            capsule_action =
            {
                type = "use-on-self",
                uses_stack = false,
                attack_parameters =
                {
                    type = "projectile",
                    activation_type = "consume",
                    range = 0,
                    cooldown = 0.1,
                    ammo_category = "JFood",
                    ammo_type =
                    {
                        category = "JFood",
                        action =
                        {
                            type = "direct",
                            action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                {
                                    type = "script",
                                    effect_id = "JFood-eaten~"..food_value.name
                                },
                                {
                                    type = "play-sound",
                                    sound =
                                    {
                                        {
                                        filename = "__JFood__/sound/eating_0.ogg",
                                        volume = 0.6
                                        },
                                        {
                                        filename = "__JFood__/sound/eating_1.ogg",
                                        volume = 0.6
                                        },
                                        {
                                        filename = "__JFood__/sound/eating_2.ogg",
                                        volume = 0.6
                                        },
                                        {
                                        filename = "__JFood__/sound/eating_3.ogg",
                                        volume = 0.6
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        data:extend{new_food}
    else
        local new_item = {
            type = "item",
            icon = "__JFood__/assets/"..food_value.icon..".png",
            icon_mipmaps = 4,
            icon_size = food_value.icon_size,
            name = food_value.name,
            order = food_value.order,
            stack_size = food_value.stack_size,
            subgroup = "JFood"
        }
        data:extend{new_item}
    end
end

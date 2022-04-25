
machines =
{
    ["Farmland"] =
    {
        name = "Farmland",
        place = "Farmland",
        icon = "Farmland",
        icon_size = 64,
        stack_size = 100,
        order = "JF-ie",
        recipe = {
            result = "Farmland",
            time = 1,
            output = 1,
            ingredients =
            {
                {"wood", 1}
            }
        },
        running_energy_cost = "100W",
        basic_energy_information = {
            type = "electric",
            buffer_capacity = "150kJ",
            usage_priority = "secondary-input",
            input_flow_limit = "150W",
            drain = "10W"
        },
        mining_time = 0.2,
        max_health = 300,
        module_infos = {
            module_specification = {
                module_info_icon_shift = {
                    0,
                    0.8
                },
                module_slots = 2
            },
            allowed_modules = {
                "speed",
                "productivity",
                "consumption",
                "pollution"
            }
        },
        animation = {
            filename = "Farmland_animated",
            priority="high",
            width = 64,
            height = 64,
            frame_count = 20,
            line_length = 10,
            animation_speed = 0.025
        }
    }
}

--control.lua
require("setup/items")

local RED    = {r=0.5,g=0,b=0,a=1}
local GREEN  = {r=0,g=0.5,b=0,a=1}
local BLUE   = {r=0,g=0,b=0.5,a=1}
local YELLOW = {r=0.5,g=0.5,b=0,a=1}
local CYAN   = {r=0,g=0.5,b=0.5,a=1}
local PINK   = {r=0.5,g=0,b=0.5,a=1}
local used_color = YELLOW

function mysplit (inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

script.on_event(defines.events.on_script_trigger_effect,
    function(event)
        local trigger_ID = event.effect_id
        t = mysplit(trigger_ID, "~")
        if t[1] == "JFood-eaten" then
            if global.sleep == nil then
                global.sleep = {}
                global.boost = {}
            end
            local boost = global.boost
            local sleep = global.sleep
            local gm = game
            if sleep and boost then
                local clear_boost_type = stats[t[2]].boost_type
                local user = event.target_entity.player
                local enable_console_output = settings.get_player_settings(user)["JFood-0-console-output"].value
                local setting_running_multiplier = settings.startup["JFood-3-running-multiplier"].value
                local setting_mining_multiplier = settings.startup["JFood-2-mining-multiplier"].value
                local setting_crafting_multiplier = settings.startup["JFood-1-crafting-multiplier"].value
                if clear_boost_type == "clear" then
                    local noboost = true
                    for tick, value in pairs(sleep) do
                        local foodType = boost[sleep[tick]][1]
                        local player_name = boost[sleep[tick]][2]
                        --local boost_multiplier = stats[foodType].boost_multiplier
                        local boost_offset = stats[foodType].boost_offset
                        --local boost_add_afterburner = stats[foodType].boost_add_afterburner
                        local boost_type = stats[foodType].boost_type
                        local player = gm.get_player(player_name)
                        if boost_type == "movement" then
                            --player.character_running_speed_modifier = ((player.character_running_speed_modifier - boost_add_afterburner) / boost_multiplier) - boost_offset
                            player.character_running_speed_modifier = player.character_running_speed_modifier - (boost_offset * setting_running_multiplier)
                            --player.character_running_speed_modifier = player.character_running_speed_modifier / boost_multiplier
                        end
                        if boost_type == "mining" then
                            --player.character_running_speed_modifier = ((player.character_running_speed_modifier - boost_add_afterburner) / boost_multiplier) - boost_offset
                            player.character_mining_speed_modifier = player.character_mining_speed_modifier - (boost_offset * setting_mining_multiplier)
                            --player.character_running_speed_modifier = player.character_running_speed_modifier / boost_multiplier
                        end
                        if boost_type == "crafting" then
                            --player.character_crafting_speed_modifier = ((player.character_crafting_speed_modifier - boost_add_afterburner) / boost_multiplier) - boost_offset
                            player.character_crafting_speed_modifier = player.character_crafting_speed_modifier - (boost_offset * setting_crafting_multiplier)
                            --player.character_crafting_speed_modifier = player.character_crafting_speed_modifier / boost_multiplier
                        end
                        if enable_console_output then
                            user.print("Clear " ..boost_type.. " boost.", used_color)
                        end
                        boost[sleep[tick]] = nil
                        sleep[tick] = nil
                        noboost = false
                        local player = event.target_entity
                        player.remove_item{name=t[2], count=1}
                        game["forces"]["player"]["item_production_statistics"].on_flow(t[2], -1)
                    end
                    if noboost then
                        if enable_console_output then
                            user.print("No boost active!", used_color)
                        end
                    end
                else
                    local allow_boost = true
                    for index, value in pairs(boost) do
                        if index == t[1] then
                            allow_boost = false
                            break
                        end
                    end
                    if allow_boost then
                        -- local foodItem = event.source_entity
                        local player = event.target_entity.player
                        local foodCooldown = stats[t[2]].cooldown
                        --local boost_multiplier = stats[t[2]].boost_multiplier
                        local boost_offset = stats[t[2]].boost_offset
                        --local boost_add_afterburner = stats[t[2]].boost_add_afterburner
                        local boost_type = stats[t[2]].boost_type
                        sleep[gm.tick + foodCooldown] = t[1]
                        boost[t[1]] = {t[2], player.name, user.name}
                        if boost_type == "movement" then
                            --player.character_running_speed_modifier = boost_add_afterburner + (player.character_running_speed_modifier + boost_offset) * boost_multiplier
                            player.character_running_speed_modifier = player.character_running_speed_modifier + (boost_offset * setting_running_multiplier)
                            --player.character_running_speed_modifier = player.character_running_speed_modifier * boost_multiplier
                        end
                        if boost_type == "mining" then
                            --player.character_running_speed_modifier = boost_add_afterburner + (player.character_running_speed_modifier + boost_offset) * boost_multiplier
                            player.character_mining_speed_modifier = player.character_mining_speed_modifier + (boost_offset * setting_mining_multiplier)
                            --player.character_running_speed_modifier = player.character_running_speed_modifier * boost_multiplier
                        end
                        if boost_type == "crafting" then
                            --player.character_running_speed_modifier = boost_add_afterburner + (player.character_running_speed_modifier + boost_offset) * boost_multiplier
                            player.character_crafting_speed_modifier = player.character_crafting_speed_modifier + (boost_offset * setting_crafting_multiplier)
                            --player.character_running_speed_modifier = player.character_running_speed_modifier * boost_multiplier
                        end
                        if enable_console_output then
                            user.print("Activate " ..boost_type.. " boost!", used_color)
                        end
                        local player = event.target_entity
                        player.remove_item{name=t[2], count=1}
                        game["forces"]["player"]["item_production_statistics"].on_flow(t[2], -1)
                    else
                        if enable_console_output then
                            user.print("You can't have multiple boosts active at the same time!", used_color)
                        end

-- set to false and remove one from the player inventory when it's actually used THEN on_flow and it works?

                    end
                end
            end
        end
    end
)

-- you can save either their index or name, and then use game.get_player(name) to fetch the valid version of them

script.on_event(defines.events.on_tick,
    function(event) 
        local boost = global.boost
        local sleep = global.sleep
        local gm = game
        if sleep and boost[sleep[event.tick]] then
            local user_name = boost[sleep[event.tick]][3]
            local enable_console_output = settings.get_player_settings(user_name)["JFood-0-console-output"].value
            local setting_running_multiplier = settings.startup["JFood-3-running-multiplier"].value
            local setting_mining_multiplier = settings.startup["JFood-2-mining-multiplier"].value
            local setting_crafting_multiplier = settings.startup["JFood-1-crafting-multiplier"].value
            local foodType = boost[sleep[event.tick]][1]
            local player_name = boost[sleep[event.tick]][2]
            local user = game.get_player(user_name)
            local player = game.get_player(player_name)
            --local boost_multiplier = stats[foodType].boost_multiplier
            local boost_offset = stats[foodType].boost_offset
            --local boost_add_afterburner = stats[foodType].boost_add_afterburner
            local boost_type = stats[foodType].boost_type
            if boost_type == "movement" then
                player.character_running_speed_modifier = player.character_running_speed_modifier - (boost_offset * setting_running_multiplier)
            end
            if boost_type == "mining" then
                player.character_mining_speed_modifier = player.character_mining_speed_modifier - (boost_offset * setting_mining_multiplier)
            end
            if boost_type == "crafting" then
                player.character_crafting_speed_modifier = player.character_crafting_speed_modifier - (boost_offset * setting_crafting_multiplier)
            end
            boost[sleep[event.tick]] = nil
            sleep[event.tick] = nil
            if enable_console_output then
                user.print(boost_type.. " boost is now reset.", used_color)
            end
        end
    end
)

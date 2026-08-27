-----------------------------------
-- Divine Might
-- Restores the clear full moon night, 00:00 to 03:00, at the Qu'Hau Spring.
-- The June 7, 2016 version update widened the window to 18:00 through 06:00 and dropped the weather.
-- Divine Might (Repeat) shares the spring and the window.
-- The Ro'Maeve moongates, bridges and fountain are already restored by era_moongate_time.
-- The weather check reads the zone. A scholar's storm does not close the spring.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/50760-Jun.-7-2016-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_divine_might', xi.pre(xi.expansion.ROV))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/outlands/Divine_Might', function(quest)
        local romaeve = quest.sections[2][xi.zone.ROMAEVE]

        -- Copy of the base handler. The spring accepts the trade on a clear full moon night.
        romaeve['QuHau_Spring'].onTrade = function(player, npc, trade)
            local vanaHour = VanadielHour()
            local weather  = player:getZone():getWeather() -- Module change

            if
                (getVanadielMoonCycle() == xi.moonCycle.FULL_MOON) and
                (vanaHour >= 0 and vanaHour < 3) and -- Module change
                (weather == xi.weather.NONE or weather == xi.weather.SUNSHINE) and -- Module change
                npcUtil.tradeHasExactly(trade, { xi.item.BOTTLE_OF_ILLUMININK, xi.item.SHEET_OF_PARCHMENT })
            then
                return quest:progressEvent(7, xi.item.SHEET_OF_PARCHMENT, xi.item.BOTTLE_OF_ILLUMININK)
            end
        end
    end)

    xi.module.modifyInteractionEntry('scripts/quests/outlands/Divine_Might_Repeat', function(quest)
        local romaeve = quest.sections[2][xi.zone.ROMAEVE]

        -- Copy of the base handler. The window also gates the chunk of light ore trade.
        romaeve['QuHau_Spring'].onTrade = function(player, npc, trade)
            local vanaHour = VanadielHour()
            local weather  = player:getZone():getWeather() -- Module change

            if
                (getVanadielMoonCycle() == xi.moonCycle.FULL_MOON) and
                (vanaHour >= 0 and vanaHour < 3) and -- Module change
                (weather == xi.weather.NONE or weather == xi.weather.SUNSHINE) -- Module change
            then
                if npcUtil.tradeHasExactly(trade, { xi.item.BOTTLE_OF_ILLUMININK, xi.item.SHEET_OF_PARCHMENT }) then
                    return quest:progressEvent(7, xi.item.SHEET_OF_PARCHMENT, xi.item.BOTTLE_OF_ILLUMININK)
                elseif
                    not player:hasKeyItem(xi.ki.MOONLIGHT_ORE) and
                    npcUtil.tradeHasExactly(trade, xi.item.CHUNK_OF_LIGHT_ORE)
                then
                    return quest:progressEvent(8)
                end
            end
        end
    end)
end)

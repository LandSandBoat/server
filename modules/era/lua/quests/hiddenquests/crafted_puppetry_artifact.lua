-----------------------------------
-- Crafted Puppetry Artifact (PUP AF)
-- Restores the JST midnight wait before a finished piece is handed over.
-- The June 7, 2016 version update shortened the wait to one Vana'diel day.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/50759
-- Source: https://forum.square-enix.com/ffxi/threads/50760-Jun.-7-2016-(JST)-Version-Update
-- Source: https://wiki.ffo.jp/html/5183.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_puppetry_attire_commission', xi.pre(xi.expansion.ROV))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/hiddenQuests/Crafted_Puppetry_Artifact', function(quest)
        local whitegate     = quest.sections[1][xi.zone.AHT_URHGAN_WHITEGATE]
        local baseOnTrigger = whitegate['Dhima_Polevhia'].onTrigger
        local baseHandler   = whitegate.onEventFinish[795]

        whitegate['Dhima_Polevhia'].onTrigger = function(player, npc)
            if player:getCharVar('[PUP]orderStage') == 2 then
                if player:getCharVar('[PUP]orderWait') ~= 0 then
                    return quest:event(796) -- Order is not ready.
                end

                -- The base Vana'diel day timer no longer applies.
                player:setCharVar('[PUP]orderTime', 0)
            end

            return baseOnTrigger(player, npc)
        end

        whitegate.onEventFinish[795] = function(player, csid, option, npc)
            baseHandler(player, csid, option, npc)

            -- Work starts when the materials are traded.
            player:setCharVar('[PUP]orderWait', 1, JstMidnight()) -- Module change: Start JST midnight timer
        end
    end)
end)

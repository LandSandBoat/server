-----------------------------------
-- Crafted Magus Artifact (BLU AF)
-- Restores the JST midnight wait before another piece can be ordered.
-- The June 7, 2016 version update shortened the wait to one Vana'diel day.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/50759
-- Source: https://forum.square-enix.com/ffxi/threads/50760-Jun.-7-2016-(JST)-Version-Update
-- Source: https://wiki.ffo.jp/html/5181.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_magus_attire_commission', xi.pre(xi.expansion.ROV))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/hiddenQuests/Crafted_Magus_Artifact', function(quest)
        local whitegate     = quest.sections[1][xi.zone.AHT_URHGAN_WHITEGATE]
        local baseOnTrigger = whitegate['Lathuya'].onTrigger

        whitegate['Lathuya'].onTrigger = function(player, npc)
            local remainingBLUAF     = player:getCharVar('[BLUAF]Remaining')
            local totalCraftedPieces = 3 - utils.mask.countBits(remainingBLUAF, 3)

            if
                player:getCharVar('[BLUAF]Current') == 0 and
                totalCraftedPieces > 0 and
                totalCraftedPieces < 3
            then
                -- Asleep message, wait until Japanese midnight passes.
                if player:getCharVar('[BLUAF]RestingTimer') ~= 0 then
                    return quest:event(737 + (8 * totalCraftedPieces - 8))
                end

                -- The base Vana'diel day timer no longer applies.
                player:setCharVar('[BLUAF]RestingDay', 0)
            end

            return baseOnTrigger(player, npc)
        end

        -- Each piece is handed over by its own event.
        for _, eventId in ipairs({ 736, 744, 752 }) do
            local baseHandler = whitegate.onEventFinish[eventId]

            whitegate.onEventFinish[eventId] = function(player, csid, option, npc)
                -- The base handler clears the bit for the piece handed over.
                local remainingBLUAF = player:getCharVar('[BLUAF]Remaining')

                baseHandler(player, csid, option, npc)

                -- A piece was handed over and another remains.
                if
                    player:getCharVar('[BLUAF]Remaining') ~= 0 and
                    player:getCharVar('[BLUAF]Remaining') ~= remainingBLUAF
                then
                    player:setCharVar('[BLUAF]RestingTimer', 1, JstMidnight()) -- Module change: Start JST midnight timer
                end
            end
        end
    end)
end)

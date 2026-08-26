-----------------------------------
-- Blue Ribbon Blues
-- Restores the JST midnight wait, and the zone change, before Kerutoto returns the purple ribbon.
-- The July 8, 2014 version update replaced both conditions with a flat wait, mistakenly one hour long.
-- The November 10, 2014 update corrected the wait to one minute.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/43135-Jul-8-2014-(JST)-Version-Update
-- Source: https://wiki.ffo.jp/html/10406.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_blue_ribbon_blues', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/windurst/Blue_Ribbon_Blues', function(quest)
        local watersOffer   = quest.sections[1][xi.zone.WINDURST_WATERS]
        local watersAccept  = quest.sections[2][xi.zone.WINDURST_WATERS]
        local baseFirstCS   = watersOffer.onEventFinish[358]
        local baseRetradeCS = watersAccept.onEventFinish[365]

        -- Kerutoto keeps the ribbon overnight, and only hands it back once the player has also zoned.
        watersOffer.onEventFinish[358] = function(player, csid, option, npc)
            baseFirstCS(player, csid, option, npc)
            quest:setVar(player, 'Timer', JstMidnight()) -- Module change
            quest:setMustZone(player) -- Module change
        end

        -- The player can hand the ribbon back a second time, which restarts the same wait.
        watersAccept.onEventFinish[365] = function(player, csid, option, npc)
            baseRetradeCS(player, csid, option, npc)
            quest:setVar(player, 'Timer', JstMidnight()) -- Module change
            quest:setMustZone(player) -- Module change
        end

        -- Copy of the base handler, with the zone change added to the wait branch.
        watersAccept['Kerutoto'].onTrigger = function(player, npc)
            local questProgress = quest:getVar(player, 'Prog')

            if questProgress == 0 then
                if
                    GetSystemTime() < quest:getVar(player, 'Timer') or
                    quest:getMustZone(player) -- Module change
                then
                    return quest:progressEvent(359)
                else
                    return quest:progressEvent(360)
                end
            elseif questProgress == 1 then
                if not player:findItem(xi.item.PURPLE_RIBBON) then
                    return quest:progressEvent(366, 0, xi.item.PURPLE_RIBBON)
                else
                    return quest:progressEvent(361, 0, xi.item.PURPLE_RIBBON)
                end
            elseif questProgress == 3 then
                return quest:progressEvent(362)
            end
        end
    end)
end)

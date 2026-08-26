-----------------------------------
-- Crafted Corsair Artifact (COR AF)
-- Restores the JST midnight wait before a finished piece is handed over.
-- The June 7, 2016 version update shortened the wait to one Vana'diel day.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/50759
-- Source: https://forum.square-enix.com/ffxi/threads/50760-Jun.-7-2016-(JST)-Version-Update
-- Source: https://wiki.ffo.jp/html/5182.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_corsair_attire_commission', xi.pre(xi.expansion.ROV))

local commissions =
{
    -- Corsair's Gants
    {
        option   = 1,
        zoneId   = xi.zone.WINDURST_WATERS,
        npcName  = 'Door_House',
        feeCsid  = 946,
        waitCsid = 945,
    },

    -- Corsair's Bottes
    {
        option   = 2,
        zoneId   = xi.zone.BASTOK_MINES,
        npcName  = 'Door_House',
        feeCsid  = 524,
        waitCsid = 523,
    },

    -- Corsair's Frac
    {
        option   = 3,
        zoneId   = xi.zone.PORT_SAN_DORIA,
        npcName  = 'Raqtibahl',
        feeCsid  = 760,
        waitCsid = 757,
    },
}

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/hiddenQuests/Crafted_Corsair_Artifact', function(quest)
        for _, commission in ipairs(commissions) do
            local zoneSection   = quest.sections[1][commission.zoneId]
            local baseOnTrigger = zoneSection[commission.npcName].onTrigger
            local baseHandler   = zoneSection.onEventFinish[commission.feeCsid]

            zoneSection[commission.npcName].onTrigger = function(player, npc)
                if
                    quest:getVar(player, 'Prog') == 4 and
                    quest:getVar(player, 'Option') == commission.option
                then
                    if quest:getVar(player, 'Wait') ~= 0 then
                        -- The base handler checks the craftsman being spoken to.
                        if baseOnTrigger(player, npc) then
                            return quest:event(commission.waitCsid)
                        end

                        return
                    end

                    -- The base Vana'diel day timer no longer applies.
                    quest:setVar(player, 'Timer', 0)
                end

                return baseOnTrigger(player, npc)
            end

            zoneSection.onEventFinish[commission.feeCsid] = function(player, csid, option, npc)
                baseHandler(player, csid, option, npc)

                quest:setTimedVar(player, 'Wait', JstMidnight()) -- Module change: Start JST midnight timer
            end
        end
    end)
end)

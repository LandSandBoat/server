-----------------------------------
-- Lest We Forget
-- Wings of the Goddess Mission 54
-----------------------------------
-- !addmission 5 53
-- Veridical Conflux : !pos -142.279 -6.749 585.239 89
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local graubergID = require('scripts/zones/Grauberg_[S]/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.LEST_WE_FORGET)

mission.reward = {}

-- NOTE: The following two tables are 0-indexed for the Augment value, as used
-- in the event options.  See: augments.sql for the first value in each row.
local firstAugInfo =
{
    {  23,  3 }, -- ACC+4
    {  25,  3 }, -- ATK+4
    {  27,  3 }, -- RACC+4
    {  29,  3 }, -- RATK+4
    {  35,  3 }, -- MACC+4
    { 133,  3 }, -- MAB+4
    {   1, 24 }, -- HP+25
    {   9, 24 }, -- MP+25
}

local secondAugInfo =
{
    {  59, 0 }, -- Regain +10
    {  60, 0 }, -- Refresh +1
    { 352, 4 }, -- Occ. grants dmg. bonus based on TP+5%
    { 353, 4 }, -- TP Bonus +250
    { 350, 2 }, -- Occ. maximizes magic accuracy+3%
    { 351, 2 }, -- Occ. quickens spellcasting+3%
    { 145, 2 }, -- Counter+3
    {  61, 4 }, -- Occ. inc. resist. to all stat. ailments +5
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.GRAUBERG_S] =
        {
            ['Veridical_Conflux'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:progressEvent(39, 89, 23, 1756):importantEvent()
                    end
                end,
            },

            ['qm_reset'] =
            {
                onTrigger = function(player, npc)
                    if
                        mission:getLocalVar(player, 'Option') == 1 and
                        not mission:getMustZone(player)
                    then
                        return mission:progressEvent(46, 89, 23, 1756, 0, 9467, 16940788, 0, 0)
                    end
                end,
            },

            afterZoneIn =
            {
                function(player)
                    if
                        not player:hasItem(xi.items.MOONSHADE_EARRING) and
                        mission:getVar(player, 'Status') == 0
                    then
                        mission:setLocalVar(player, 'Option', 1)
                    end
                end,
            },

            onEventUpdate =
            {
                [39] = function(player, csid, option, npc)
                    if option > 0 then
                        local firstAugSel  = bit.band(bit.rshift(option, 1), 0xF)
                        local secondAugSel = bit.band(bit.rshift(option, 17), 0xF)

                        local firstAugmentParam = bit.lshift(firstAugInfo[firstAugSel][2], 27) + bit.lshift(firstAugInfo[firstAugSel][1], 16) + 770
                        local secondAugmentParam = bit.lshift(secondAugInfo[secondAugSel][2], 11) + secondAugInfo[secondAugSel][1]

                        player:updateEvent(firstAugmentParam, secondAugmentParam)
                    end
                end,
            },

            onEventFinish =
            {
                [39] = function(player, csid, option, npc)
                    if option ~= 1073741824 then
                        local ID           = zones[player:getZoneID()]
                        local firstAugSel  = bit.band(bit.rshift(option, 1), 0xF)
                        local secondAugSel = bit.band(bit.rshift(option, 17), 0xF)

                        if player:getFreeSlotsCount() < 1 then
                            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED)
                        else
                            player:addItem(xi.items.MOONSHADE_EARRING, 1,
                                firstAugInfo[firstAugSel][1],
                                firstAugInfo[firstAugSel][2],
                                secondAugInfo[secondAugSel][1],
                                secondAugInfo[secondAugSel][2]
                            )

                            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.MOONSHADE_EARRING)

                            mission:setVar(player, 'Status', 0)
                        end
                    end
                end,

                [46] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.MAIDEN_OF_THE_DUSK)
                        player:delMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.WHERE_IT_ALL_BEGAN)
                        player:delMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.A_TOKEN_OF_TROTH)
                        player:delMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.LEST_WE_FORGET)

                        player:addMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.MAIDEN_OF_THE_DUSK)
                        xi.mission.setVar(player, xi.mission.log_id.WOTG, xi.mission.id.wotg.MAIDEN_OF_THE_DUSK, 'Status', 2)

                        npcUtil.giveKeyItem(player, xi.ki.PRIMAL_GLOW)
                        player:messageSpecial(graubergID.text.YOU_HAVE_RETRACED_RIVER)
                    else
                        mission:setMustZone(player)
                    end
                end,
            },
        },
    },
}

return mission

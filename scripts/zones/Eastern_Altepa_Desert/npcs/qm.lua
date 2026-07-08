-----------------------------------
-- Area: Eastern Altepa Desert
--  NPC: ???
-- Involved In Quest: A Craftsman's Work
-- !pos 113 -7.972 -72 114
-----------------------------------
local ID = zones[xi.zone.EASTERN_ALTEPA_DESERT]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local decurioKilled = player:getCharVar('Decurio_I_IIIKilled')

    if
        player:getCharVar('aCraftsmanWork') == 1 and
        decurioKilled == 0 and
        npcUtil.popFromQM(player, npc, ID.mob.DECURIO_I_III, { hide = 0, })
    then
        player:messageSpecial(ID.text.FEEL_A_HOSTILE_GAZE)
    elseif decurioKilled == 1 then
        npcUtil.giveKeyItem(player, xi.ki.ALTEPA_POLISHING_STONE)
        player:setCharVar('aCraftsmanWork', 2)
        player:setCharVar('Decurio_I_IIIKilled', 0)
    else
        player:messageSpecial(ID.text.REMNANTS_OF_A_PAST_AGE)
    end
end

return entity

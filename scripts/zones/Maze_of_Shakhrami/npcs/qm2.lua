-----------------------------------
-- Area: Maze of Shakhrami
--  NPC: qm2
-- Note: Spawns Wyrmflies for Eco-Warrior (Windurst)
-- !pos 143 9 -219 198
-----------------------------------
local ID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wyrmfly = ID.mob.WYRMFLY_OFFSET

    if
        player:getCharVar('EcoStatus') == 201 and
        player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION)
    then
        npcUtil.popFromQM(player, npc, { wyrmfly, wyrmfly + 1, wyrmfly + 2 }, { claim = true, look = true, hide = 0 })
    elseif
        player:getCharVar('EcoStatus') == 202 and
        not player:hasKeyItem(xi.ki.INDIGESTED_MEAT)
    then
        npcUtil.giveKeyItem(player, xi.ki.INDIGESTED_MEAT)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity

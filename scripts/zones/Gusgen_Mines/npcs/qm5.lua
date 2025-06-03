-----------------------------------
-- Area: Gusgen Mines
--  NPC: qm5
-- Note: Spawns Puddings for Eco-Warrior (Bastok)
-- !pos 22.796 -61.156 -19.687 196
-----------------------------------
local ID = zones[xi.zone.GUSGEN_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local pudding = ID.mob.PUDDING_OFFSET

    if
        player:getCharVar('EcoStatus') == 101 and
        player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION)
    then
        npcUtil.popFromQM(player, npc, { pudding, pudding + 1 }, { claim = true, look = true, hide = 0 })
    elseif
        player:getCharVar('EcoStatus') == 102 and
        not player:hasKeyItem(xi.ki.INDIGESTED_ORE)
    then
        npcUtil.giveKeyItem(player, xi.ki.INDIGESTED_ORE)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity

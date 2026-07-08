-----------------------------------
-- Area: Ordelle's Caves
--  NPC: qm7
-- Note: Spawns Necroplasm for Eco-Warrior (San d'Oria)
-- !pos -116 30 50 193
-----------------------------------
local ID = zones[xi.zone.ORDELLES_CAVES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getCharVar('EcoStatus') == 1 and
        player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION)
    then
        npcUtil.popFromQM(player, npc, ID.mob.NECROPLASM, { claim = true, look = true, hide = 0 })
    elseif
        player:getCharVar('EcoStatus') == 2 and
        not player:hasKeyItem(xi.ki.INDIGESTED_STALAGMITE)
    then
        npcUtil.giveKeyItem(player, xi.ki.INDIGESTED_STALAGMITE)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity

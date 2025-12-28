-----------------------------------
-- Area: Al'Taieu
--  NPC: qm_jailer_of_justice (???)
-- Allows players to spawn the Jailer of Justice by trading the Second Virtue, Deed of Moderation, and HQ Xzomit Organ to a ???.
-- !pos , -278 0 -463
-----------------------------------
local ID = zones[xi.zone.ALTAIEU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, { xi.item.SECOND_VIRTUE, xi.item.DEED_OF_MODERATION, xi.item.HIGH_QUALITY_XZOMIT_ORGAN }) and
        npcUtil.popFromQM(player, npc, ID.mob.JAILER_OF_JUSTICE)
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(201)
end

return entity

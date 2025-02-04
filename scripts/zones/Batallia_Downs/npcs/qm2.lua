-----------------------------------
-- Area: Batallia Downs
--  NPC: qm2 (???)
-- Pop for the quest 'Chasing Quotas'
-----------------------------------
local ID = zones[xi.zone.BATALLIA_DOWNS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local sturmtigerKilled = player:getCharVar('SturmtigerKilled')

    if
        player:getCharVar('ChasingQuotas_Progress') == 5 and
        sturmtigerKilled == 0
    then
        SpawnMob(ID.mob.STURMTIGER, 300):updateClaim(player)
    elseif sturmtigerKilled == 1 then
        npcUtil.giveKeyItem(player, xi.ki.RANCHURIOMES_LEGACY)
        player:setCharVar('ChasingQuotas_Progress', 6)
        player:setCharVar('SturmtigerKilled', 0)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity

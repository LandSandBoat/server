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
        sturmtigerKilled == 0 and
        npcUtil.popFromQM(player, npc, ID.mob.STURMTIGER, { hide = 0, })
    then
        player:messageSpecial(ID.text.SENSE_AN_EVIL_PRESENCE)
    elseif sturmtigerKilled == 1 then
        npcUtil.giveKeyItem(player, xi.ki.RANCHURIOMES_LEGACY)
        player:setCharVar('ChasingQuotas_Progress', 6)
        player:setCharVar('SturmtigerKilled', 0)
    else
        player:messageSpecial(ID.text.SOMEONE_DUG)
    end
end

return entity

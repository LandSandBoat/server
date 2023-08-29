-----------------------------------
-- Area: Batallia Downs
--  Mob: Sturmtiger
-- Involved in Quest: Chasing Quotas
-- !pos -715.882, -10.75, 65.982 (105)
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player:getCharVar('ChasingQuotas_Progress') == 5 then
        player:setCharVar('SturmtigerKilled', 1)
    end
end

return entity

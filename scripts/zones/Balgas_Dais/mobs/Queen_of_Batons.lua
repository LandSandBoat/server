-----------------------------------
-- Area: Balga's Dais
-- NM:
-- KSNM: Royale Ramble
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:SetMod(xi.mod.DOUBLE_ATTACK, 50)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.STANDBACK))
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 691 then
        mob:setMod(xi.mod.REGAIN, 100)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity

-----------------------------------
-- Area: Balga's Dais
--  Mob: Wyrm
-- KSNM: Early Bird Catches the Wyrm
-- For future reference: Trusts are not allowed in this fight
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1) -- has a bug during flight, like Tiamat
    mob:setTP(3000) -- opens fight with a skill
end

entity.onMobEngaged = function(mob, target)
    mob:setMod(xi.mod.REGAIN, 100) -- very close to the capture by comparing stop watch measures
    mob:setMod(xi.mod.REGEN, 100) -- might be higher: capture showed no change in HP with Poison II and Bio III procced
end

local function notBusy(mob)
    local action = mob:getCurrentAction()
    if
        action == xi.act.MOBABILITY_START or
        action == xi.act.MOBABILITY_USING or
        action == xi.act.MOBABILITY_FINISH
    then
        return false -- when the Wyrm is in any stage of using a mobskill
    else
        return true
    end
end

entity.onMobFight = function(mob, target)

    -- Return to ground at 33% HP
    if
        mob:getAnimationSub() == 1 and -- is flying
        mob:getHPP() <= 33 and
        notBusy(mob)
    then
        mob:useMobAbility(954)
        -- Touchdown will set the following for us in the skill script:
        -- lifted wings model stance: mob:setAnimationSub(2)
        -- reset default attack:      mob:SetMobSkillAttack(0)
        -- reset melee attacks:       mob:delStatusEffect(xi.effect.ALL_MISS)
        mob:addStatusEffect(xi.effect.EVASION_BOOST, 75, 0, 0)
        mob:addStatusEffect(xi.effect.DEFENSE_BOOST, 75, 0, 0)
        mob:addStatusEffect(xi.effect.MAGIC_DEF_BOOST, 75, 0, 0)
        mob:setMobMod(xi.mobMod.SKILL_LIST, 262) -- restore standard ground skill set
        mob:setBehaviour(1024) -- reset behavior to not face target

    -- Go airborne at 66% HP, gets only called once
    -- TODO: Should move physically to center/origin before taking off; maybe with pathTo()?
    elseif
        mob:getHPP() > 33 and
        mob:getHPP() <= 66 and
        mob:getAnimationSub() == 0 and -- is on ground
        notBusy(mob)
    then
        mob:setAnimationSub(1) -- flying model stance
        mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0) -- melee attacks miss now
        mob:SetMobSkillAttack(1146) -- change default attack to ranged fire magic damage
        mob:setMobMod(xi.mobMod.SKILL_LIST, 1147) -- change skill set to flying moves
        mob:setBehaviour(0) -- face target while flying
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity

-----------------------------------
-- Area: Balga's Dais
--  Mob: Wyrm
-- KSNM: Early Bird Catches the Wyrm
-- For future reference: Trusts are not allowed in this fight 
-----------------------------------
require("scripts/globals/status")

function onMobInitialize(mob)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1) -- has a bug during flight, like Tiamat
    mob:setTP(3000) -- opens fight with a skill
end

function onMobEngaged(mob, target)
    mob:setMod(tpz.mod.REGAIN, 100) -- very close to the capture by comparing stop watch measures
    mob:setMod(tpz.mod.REGEN, 100) -- might be higher: capture showed no change in HP with Poison II and Bio III procced
end

local function notBusy(mob)
    local action = mob:getCurrentAction()
    if
        action == tpz.act.MOBABILITY_START or
        action == tpz.act.MOBABILITY_USING or
        action == tpz.act.MOBABILITY_FINISH
    then
        return false -- when the Wyrm is in any stage of using a mobskill
    else
        return true
    end
end

function onMobFight(mob, target)

    -- Return to ground at 33% HP
    if
        mob:AnimationSub() == 1 and -- is flying
        mob:getHPP() <= 33 and
        notBusy(mob)
    then
        mob:useMobAbility(954)
        -- Touchdown will set the following for us in the skill script:
        -- lifted wings model stance: mob:AnimationSub(2)
        -- reset default attack:      mob:SetMobSkillAttack(0)
        -- reset melee attacks:       mob:delStatusEffect(tpz.effect.TOO_HIGH)
        mob:addStatusEffect(tpz.effect.EVASION_BOOST, 75, 0, 0)
        mob:addStatusEffect(tpz.effect.DEFENSE_BOOST, 75, 0, 0)
        mob:addStatusEffect(tpz.effect.MAGIC_DEF_BOOST, 75, 0, 0)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 262) -- restore standard ground skill set
        mob:setBehaviour(1024) -- reset behavior to not face target

    -- Go airborne at 66% HP, gets only called once
    -- TODO: Should move physically to center/origin before taking off; maybe with pathTo()?
    elseif
        mob:getHPP() > 33 and
        mob:getHPP() <= 66 and
        mob:AnimationSub() == 0 and -- is on ground
        notBusy(mob)
    then
        mob:AnimationSub(1) -- flying model stance
        mob:addStatusEffectEx(tpz.effect.TOO_HIGH, 0, 1, 0, 0) -- melee attacks miss now
        mob:SetMobSkillAttack(1146) -- change default attack to ranged fire magic damage
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 1147) -- change skill set to flying moves
        mob:setBehaviour(0) -- face target while flying
    end
end

function onMobDeath(mob, player, isKiller)
end

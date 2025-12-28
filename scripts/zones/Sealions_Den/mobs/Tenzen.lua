-----------------------------------
-- Area: Sealion's Den
--  Mob: Tenzen
-----------------------------------
local ID = zones[xi.zone.SEALIONS_DEN]
-----------------------------------
---@type TMobEntity
local entity = {}

local formTable =
{
    [0] = {    0,     0, xi.behavior.NONE,      true  }, -- Melee unseathed.
    [1] = { 2056, -1200, xi.behavior.STANDBACK, false }, -- Bow low.
    [2] = { 2055, -2400, xi.behavior.STANDBACK, false }, -- Bow high.
    [3] = {    0,     0, xi.behavior.NONE,      false }, -- Melee seathed.
}

local weaponskillTable =
{
    [0] = { xi.mobSkill.AMATSU_HANAIKUSA   },
    [1] = { xi.mobSkill.AMATSU_TORIMAI     },
    [2] = { xi.mobSkill.AMATSU_KAZAKIRI    },
    [3] = { xi.mobSkill.AMATSU_TSUKIKAGE   },
    [4] = { xi.mobSkill.COSMIC_ELUCIDATION },
}
local function setupForm(mob, newForm)
    mob:timer(1500, function(mobArg)
        mobArg:setAnimationSub(newForm)
        mobArg:setMobSkillAttack(formTable[newForm][1])
        mobArg:setMod(xi.mod.DELAY, formTable[newForm][2])
        mobArg:setBehavior(formTable[newForm][3])
        mobArg:setMobAbilityEnabled(formTable[newForm][4])
    end)
end

local function wsSequence(mob)
    local step       = mob:getLocalVar('[Tenzen]MeikyoStep')
    local breakChain = (step <= 3 and not mob:hasStatusEffect(xi.effect.MEIKYO_SHISUI)) and true or false -- If "Amatsu Tsukikage" happens, Cosmic Euclidation happens. You loose.

    if breakChain then
        mob:setAutoAttackEnabled(true)
        mob:setMobAbilityEnabled(true)

        mob:setLocalVar('[Tenzen]MorphingTime', mob:getBattleTime())
        mob:setLocalVar('[Tenzen]MeikyoActive', 0)
        mob:setLocalVar('[Tenzen]MeikyoStep', 0)

        return
    end

    -- Chance was given to break sequence. Continue.
    mob:setTP(1000)
    mob:useMobAbility(weaponskillTable[step][1])
    mob:setLocalVar('[Tenzen]MeikyoStep', step + 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DEF, 350)
    mob:setMod(xi.mod.REGAIN, 30)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
    mob:setMobMod(xi.mobMod.ROAM_TURNS, 0)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 10)

    -- Setup melee form.
    setupForm(mob, 0)

    -- Reset action usage
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setUnkillable(true)

    -- Reset local vars.
    mob:setLocalVar('[Tenzen]LastWeaponskill', 0)
    mob:setLocalVar('[Tenzen]Riceball', 0)
    mob:setLocalVar('[Tenzen]MorphingTime', 0)
    mob:setLocalVar('[Tenzen]MeikyoActive', 0)
    mob:setLocalVar('[Tenzen]MeikyoUses', 0)
    mob:setLocalVar('[Tenzen]MeikyoStep', 0)
    mob:setLocalVar('[Tenzen]MeikyoHPP', 80)
end

entity.onMobEngage = function(mob, target)
    mob:showText(mob, ID.text.TENZEN_MSG_OFFSET + 1)

    -- Update Taru helpers enmity.
    local mobId  = mob:getID()

    for taruId = mobId + 1, mobId + 3 do
        GetMobByID(taruId):updateEnmity(target)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillId = skill:getID()

    -- Track last time Tenzen did a mobskill. Dont Meikyo Shisui immediately after.
    mob:setLocalVar('[Tenzen]LastWeaponskill', mob:getBattleTime())

    -- Setup weaponskill chain.
    if skillId == xi.mobSkill.MEIKYO_SHISUI_1 then
        mob:setAutoAttackEnabled(false)
        mob:setMobAbilityEnabled(false)

        mob:setLocalVar('[Tenzen]MeikyoActive', 1)
        mob:setLocalVar('[Tenzen]MeikyoUses', mob:getLocalVar('[Tenzen]MeikyoUses') + 1)
        mob:setLocalVar('[Tenzen]MeikyoHPP', 60)

    -- Chance of switching from high bow form to low bow form.
    elseif skillId == xi.mobSkill.RANGED_ATTACK_TENZEN_1 then
        if math.random(1, 100) <= 25 then
            setupForm(mob, 1)
        end

    -- Chance of switching from low bow form to high bow form.
    elseif skillId == xi.mobSkill.RANGED_ATTACK_TENZEN_2 then
        if math.random(1, 100) <= 25 then
            setupForm(mob, 2)
        end

    -- Loose battle.
    elseif skillId == xi.mobSkill.COSMIC_ELUCIDATION then
        mob:timer(2000, function(mobArg)
            mobArg:setAnimationSub(3)
            mobArg:showText(mobArg, ID.text.TENZEN_MSG_OFFSET + 1)
            mobArg:getBattlefield():lose()
        end)
    end
end

entity.onMobFight = function(mob, target)
    local mobHPP = mob:getHPP()

    -- Win battle.
    if mobHPP <= 15 then
        mob:setAnimationSub(3)
        mob:showText(target, ID.text.TENZEN_MSG_OFFSET + 2)

        mob:timer(2000, function(mobArg)
            mobArg:getBattlefield():win()
        end)

        return
    end

    -- Enhance regain.
    if mobHPP <= 35 then
        mob:setMod(xi.mod.REGAIN, 70)
    end

    -- If mob is busy or otherwise unable to perform actions.
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Scripted sequence of weaponskills in order to potentially create the level 4 skillchain cosmic elucidation
    if mob:getLocalVar('[Tenzen]MeikyoActive') == 1 then
        mob:timer(1500, function(mobArg)
            wsSequence(mobArg)
        end)

        return
    end

    -- Rice ball
    if
        mob:getHPP() <= 70 and
        mob:getLocalVar('[Tenzen]Riceball') == 0
    then
        mob:showText(target, ID.text.TENZEN_MSG_OFFSET + 3)
        mob:useMobAbility(xi.mobSkill.RICEBALL_TENZEN)
        mob:setLocalVar('[Tenzen]Riceball', 1)
        return
    end

    -- Meikyo Shisui
    if
        mob:getAnimationSub() == 0 and
        mob:getLocalVar('[Tenzen]LastWeaponskill') <= mob:getBattleTime() - 5 and
        mob:getLocalVar('[Tenzen]MeikyoActive') == 0 and
        mob:getLocalVar('[Tenzen]MeikyoUses') <= 1 and
        mob:getLocalVar('[Tenzen]MeikyoHPP') >= mobHPP
    then
        mob:useMobAbility(xi.mobSkill.MEIKYO_SHISUI_1)
        return
    end

    local changeTime   = mob:getBattleTime() - mob:getLocalVar('[Tenzen]MorphingTime')
    local animationSub = mob:getAnimationSub()
    local cooldown     = animationSub == 0 and 90 or 45

    if
        changeTime > cooldown and
        animationSub <= 1
    then
        local newForm = animationSub == 0 and 1 or 0
        mob:setLocalVar('[Tenzen]MorphingTime', mob:getBattleTime())
        setupForm(mob, newForm)
    end
end

return entity

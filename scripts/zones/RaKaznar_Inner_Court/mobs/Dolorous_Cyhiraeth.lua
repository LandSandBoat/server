-----------------------------------
-- Area: RaKaznar_Inner_Court
--  Mob: Dolorous Cyhiraeth
-- ERA Custom NM
-----------------------------------
local entity = {}

local function getWaywardBhoot()
    return GetMobByID(zones[xi.zone.RAKAZNAR_INNER_COURT].mob.WAYWARD_BHOOT)
end

-- HP% thresholds at which phase abilities are used
local phaseAbilities =
{
    { hpp = 75, skillId = xi.mobSkill.ELECTROCHARGE,  varState = 1 },
    { hpp = 50, skillId = xi.mobSkill.ICE_BREAK,      varState = 2 },
    { hpp = 30, skillId = xi.mobSkill.SILENCE_GAS_1,  varState = 3 },
    { hpp = 10, skillId = xi.mobSkill.PILE_PITCH,     varState = 4 },
}

-- Status effects the mob will instantly cleanse and retaliate against
local cleanseReactions =
{
    { effect = xi.effect.STUN,     skillId = xi.mobSkill.WINTER_BREEZE },
    { effect = xi.effect.SILENCE,  skillId = xi.mobSkill.VOICELESS_STORM },
    { effect = xi.effect.SLEEP_I,  skillId = xi.mobSkill.SPRING_BREEZE },
    { effect = xi.effect.SLEEP_II, skillId = xi.mobSkill.SPRING_BREEZE },
    { effect = xi.effect.LULLABY,  skillId = xi.mobSkill.SPRING_BREEZE },
}

entity.onMobEngaged = function(mob, target)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, -1)
    mob:setMod(xi.mod.AQUAVEIL_COUNT, 20)
    mob:setMod(xi.mod.BINDRES,        20)
    mob:setMod(xi.mod.SLEEPRES,      -100)
    mob:setMod(xi.mod.GRAVITYRES,     30)
    mob:setMod(xi.mod.REFRESH,        300)
    mob:setMod(xi.mod.REGEN,          5)
    mob:setMod(xi.mod.SILENCERES,    -100)
    mob:setMod(xi.mod.STUNRES,       -100)
    mob:setMod(xi.mod.LULLABYRES,    -100)
    mob:setMod(xi.mod.FASTCAST,       50)
end

entity.onMobFight = function(mob, target)
    local bhoot = getWaywardBhoot()
    local hpp        = mob:getHPP()
    local phaseState = mob:getLocalVar('PhaseState')

    if bhoot and not bhoot:isSpawned() then
        mob:setUnkillable(false)
    end

    -- Blaze spikes immunity: immune to physical/ranged and gains regen
    if mob:hasStatusEffect(xi.effect.BLAZE_SPIKES) then
        mob:setMod(xi.mod.UDMGRANGE, -10000)
        mob:setMod(xi.mod.UDMGPHYS,  -10000)
        mob:setMod(xi.mod.REGEN,     math.floor(mob:getMaxHP() / 100))
    else
        mob:setMod(xi.mod.UDMGRANGE, 0)
        mob:setMod(xi.mod.UDMGPHYS,  0)
        mob:setMod(xi.mod.REGEN,     0)
    end

    -- Reset phase tracker when mob is at full HP
    if hpp == 100 then
        mob:setLocalVar('PhaseState', 0)
        return
    end

    -- Phase ability triggers
    for _, phase in ipairs(phaseAbilities) do
        if hpp < phase.hpp and phaseState == phase.varState - 1 then
            mob:setLocalVar('PhaseState', phase.varState)
            mob:useMobAbility(phase.skillId)
            mob:resetEnmity(target)
            return
        end
    end

    -- Heal Cyhiraeth if she drops below 26% and Bhoot is still alive
    if hpp < 26 and bhoot and bhoot:isSpawned() then
        mob:addHP(math.floor(mob:getMaxHP() * 0.75))
        return
    end

    -- Cleanse debuffs and retaliate
    for _, reaction in ipairs(cleanseReactions) do
        if mob:hasStatusEffect(reaction.effect) then
            mob:delStatusEffect(reaction.effect)
            mob:useMobAbility(reaction.skillId)
            return
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local battletarget = mob:getTarget()
    local t            = battletarget:getPos()
    local pos          = NearLocation(t, 1.5, math.random() * math.pi)
    pos.rot            = battletarget:getRotPos()

    mob:resetEnmity(target)
    mob:teleport(pos, battletarget)
    skill:setMsg(0)
end

entity.onSpellPrecast = function(mob, spell)
    mob:setMod(xi.mod.AQUAVEIL_COUNT, 20)
end

entity.onMobDisengage = function(mob)
    mob:setUnkillable(true)
    mob:setMod(xi.mod.BINDRES,        0)
    mob:setMod(xi.mod.SLEEPRES,       0)
    mob:setMod(xi.mod.GRAVITYRES,     0)
    mob:setMod(xi.mod.REFRESH,        0)
    mob:setMod(xi.mod.REGEN,          0)
    mob:setMod(xi.mod.AQUAVEIL_COUNT, 0)
    mob:setMod(xi.mod.LULLABYRES,     0)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
end

return entity

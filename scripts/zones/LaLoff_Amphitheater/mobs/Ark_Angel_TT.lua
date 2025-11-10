-----------------------------------
-- Area: LaLoff Amphitheater
--  Mob: Ark Angel TT
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- Teleport configuration per battlefield area
local teleportConfig =
{
    [1] =
    {
        positions =
        {
            { x = -4.3049,  y = -18.7165, z = 8.0389 },
            { x = -14.0846, y = -18.7165, z = 2.5141 },
            { x = -23.9627, y = -18.7166, z = 8.3264 },
            { x = -23.9330, y = -18.7166, z = 19.7055 },
            { x = -13.9459, y = -18.7165, z = 25.3625 },
            { x = -4.0575,  y = -18.7165, z = 19.4814 },
        },
    },
    [2] =
    {
        positions =
        {
            { x = -552.6158, y = -242.6685, z = 50.5000 },
            { x = -562.7487, y = -242.6685, z = 44.9965 },
            { x = -572.2888, y = -242.6685, z = 50.8514 },
            { x = -572.2892, y = -242.6685, z = 62.1094 },
            { x = -562.4214, y = -242.6685, z = 67.8410 },
            { x = -552.5865, y = -242.6685, z = 62.1100 },
        },
    },
    [3] =
    {
        positions =
        {
            { x = 487.2722, y = -317.6705, z = 73.7913 },
            { x = 477.4464, y = -317.6705, z = 68.1639 },
            { x = 467.5475, y = -317.6705, z = 73.9140 },
            { x = 467.7256, y = -317.6705, z = 85.3578 },
            { x = 477.5184, y = -317.6706, z = 90.8512 },
            { x = 487.4566, y = -317.6705, z = 85.0588 },
        },
    },
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.CAN_PARRY, 3)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
    mob:addMod(xi.mod.UFASTCAST, 30)
    mob:addMod(xi.mod.REGAIN, 90)
    mob:addMod(xi.mod.REGEN, 12)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob,
        {
            between = 30,
            specials =
            {
                { id = xi.jsa.BLOOD_WEAPON },
                { id = xi.jsa.MANAFONT },
            },
        })

    -- Set up warp behavior listeners
    mob:addListener('WEAPONSKILL_STATE_EXIT', 'WARP_OUT_COMPLETE', function(ttMob, skillId)
        if skillId == xi.mobSkill.ARKANGEL_TT_WARP_OUT then
            local config = teleportConfig[ttMob:getBattlefield():getArea()]
            if config then
                local currentX = ttMob:getXPos()
                local currentZ = ttMob:getZPos()
                local targetPosition = utils.randomEntry(config.positions)

                -- Reroll if we picked the current position
                while targetPosition and targetPosition.x == currentX and targetPosition.z == currentZ do
                    targetPosition = utils.randomEntry(config.positions)
                end

                if targetPosition then
                    ttMob:setPos(targetPosition.x, targetPosition.y, targetPosition.z, ttMob:getRotPos())
                    ttMob:queue(0, function(mobArg)
                        mobArg:useMobAbility(xi.mobSkill.ARKANGEL_TT_WARP_IN, nil, 0)
                    end)
                end
            end
        elseif skillId == xi.mobSkill.ARKANGEL_TT_WARP_IN then
            mob:setMagicCastingEnabled(true)
        end
    end)

    mob:addListener('MAGIC_USE', 'TT_SPELL_CAST', function(ttMob, target, spell, action)
        if target and target:isPC() then
            ttMob:setLocalVar('spellCastSinceWarp', 1)
        end
    end)
end

entity.onMobEngage = function(mob, target)
    local mobid = mob:getID()

    for member = mobid-5, mobid + 2 do
        local m = GetMobByID(member)
        if m and m:getCurrentAction() == xi.action.ROAMING then
            m:updateEnmity(target)
        end
    end

    mob:setLocalVar('nextWarpCheck', GetSystemTime() + 17)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
end

entity.onMobFight = function(mob, target)
    local hasBloodWeapon = mob:hasStatusEffect(xi.effect.BLOOD_WEAPON)
    local hasStandback = bit.band(mob:getBehavior(), xi.behavior.STANDBACK) > 0

    -- Allow TT to move during Blood Weapon
    if hasBloodWeapon and hasStandback then
        mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.STANDBACK)))
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    elseif not hasBloodWeapon and not hasStandback then
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.STANDBACK))
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    end

    if not xi.combat.behavior.isEntityBusy(mob) and not hasBloodWeapon then
        local currentTime = GetSystemTime()
        if currentTime >= mob:getLocalVar('nextWarpCheck') then
            if mob:getLocalVar('spellCastSinceWarp') == 0 then
                mob:disengage()
            else
                local config = teleportConfig[mob:getBattlefield():getArea()]
                if config then
                    if mob:hasStatusEffect(xi.effect.MANAFONT) then
                        mob:setLocalVar('nextWarpCheck', currentTime + 10)
                    else
                        mob:setLocalVar('nextWarpCheck', currentTime + 17)
                    end

                    mob:setLocalVar('spellCastSinceWarp', 0)
                    mob:useMobAbility(xi.mobSkill.ARKANGEL_TT_WARP_OUT, nil, 0)
                    mob:setMagicCastingEnabled(false)
                end
            end
        end
    end
end

entity.onMobDisengage = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

return entity

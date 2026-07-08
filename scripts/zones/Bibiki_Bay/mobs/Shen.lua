-----------------------------------
-- Area: Bibiki Bay
--   NM: Shen
-- !pos -102.540 2.087 -725.207 4
-----------------------------------
---@type TMobEntity
local entity = {}

local status =
{
    OUTSIDE_SHELL = 0,
    INSIDE_SHELL  = 1,
}

local function enterShell(mob)
    mob:setAnimationSub(status.INSIDE_SHELL)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setMod(xi.mod.UDMGPHYS, -8500)
    mob:setMod(xi.mod.UDMGRANGE, -8500)
    mob:setMod(xi.mod.UDMGMAGIC, -7500)
    mob:setMod(xi.mod.UDMGBREATH, -7500)
    mob:setMod(xi.mod.REGEN, 100)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 250)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
end

local function exitShell(mob)
    mob:setAnimationSub(status.OUTSIDE_SHELL)
    mob:setAutoAttackEnabled(true)
    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.UDMGMAGIC, 0)
    mob:setMod(xi.mod.UDMGBREATH, 0)
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 251)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.WATER_ABSORB, 100)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 250)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMod(xi.mod.POWER_MULTIPLIER_SPELL, 5)
    mob:setMod(xi.mod.REGAIN, 50)

    -- Ensure non-shell form.
    exitShell(mob)

    -- Handle initial variables.
    local currentTime = GetSystemTime()
    mob:setLocalVar('petReviveTimer', currentTime + 60)
    mob:setLocalVar('healTimer', currentTime + math.randomInt(30, 120))

    -- Default to disabled magic casting. Judge inside onMobFight if it can cast.
    mob:setMagicCastingEnabled(false)
end

entity.onMobFight = function(mob, target)
    local mobId = mob:getID()

    -- Early return: Fatal error -> Filtrate(1) not defined.
    local filtrateOne = GetMobByID(mobId + 1)
    if not filtrateOne then
        return
    end

    -- Early return: Fatal error -> Filtrate(2) not defined.
    local filtrateTwo = GetMobByID(mobId + 2)
    if not filtrateTwo then
        return
    end

    -- Filtrate pet logic. Every 30-120 seconds have one of the filtrates heal Shen via a water spell.
    local currentTime = GetSystemTime()
    if currentTime > mob:getLocalVar('healTimer') then
        for _, filtrate in ipairs(utils.shuffle({ filtrateOne, filtrateTwo })) do
            if
                filtrate:isAlive() and
                filtrate:checkDistance(mob) < 20 and
                not xi.combat.behavior.isEntityBusy(filtrate)
            then
                local spells = { [1] = xi.magic.spell.WATER_IV, [2] = xi.magic.spell.WATER_III }
                filtrate:castSpell(spells[math.randomInt(1, #spells)], mob)
                mob:setLocalVar('healTimer', currentTime + math.randomInt(30, 120))
                break
            end
        end
    end

    -- Early return: Entity is busy.
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Shen logic.
    switch (mob:getAnimationSub()): caseof
    {
        [status.OUTSIDE_SHELL] = function()
            -- Judge spellcasting availability.
            mob:setMagicCastingEnabled(mob:checkDistance(target) <= mob:getMeleeRange(target))

            -- Can enter shell.
            if
                filtrateOne:isSpawned() and
                filtrateTwo:isSpawned() and
                currentTime >= mob:getLocalVar('shellTimer')
            then
                mob:setLocalVar('shellTimer', currentTime + math.randomInt(30, 120))
                enterShell(mob)
            end
        end,

        [status.INSIDE_SHELL] = function()
            -- Go out of shell immediately the moment a pet isn't present or when the time is up.
            if
                not filtrateOne:isSpawned() or
                not filtrateTwo:isSpawned() or
                currentTime >= mob:getLocalVar('shellTimer')
            then
                mob:setLocalVar('shellTimer', currentTime + math.randomInt(30, 120))
                exitShell(mob)
            end
        end,
    }
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local mobId       = mob:getID()
    local filtrateOne = GetMobByID(mobId + 1)
    local filtrateTwo = GetMobByID(mobId + 2)

    -- Flood.
    if
        (filtrateOne and not filtrateOne:isSpawned()) or
        (filtrateTwo and not filtrateTwo:isSpawned())
    then
        -- Check if it can revive a pet.
        local currentTime = GetSystemTime()
        if currentTime >= mob:getLocalVar('petReviveTimer') then
            mob:setMod(xi.mod.UFASTCAST, 100)
            mob:setLocalVar('petReviveTimer', currentTime + 25)

            return xi.magic.spell.FLOOD
        end
    end

    -- Reset insta-cast.
    mob:setMod(xi.mod.UFASTCAST, 0)

    -- Regular spells.
    local spellList =
    {
        [1] = xi.magic.spell.WATER_IV,
        [2] = xi.magic.spell.WATERGA_III,
    }

    return spellList[math.randomInt(1, #spellList)]
end

entity.onSpellPrecast = function(mob, spell)
    -- Early return: Not flood.
    if spell:getID() ~= xi.magic.spell.FLOOD then
        return
    end

    -- Early return: No target.
    local target = mob:getTarget()
    if not target then
        return
    end

    -- Fetch data needed.
    local mobId = mob:getID()
    local pos   = target:getPos()

    -- Check pet status and spawn if needed.
    for i = 1, 2 do
        local pet = GetMobByID(mobId + i)
        if pet and not pet:isSpawned() then
            SpawnMob(mobId + i)
            pet:updateEnmity(target)
            pet:setPos(pos.x, pos.y, pos.z, pos.rot)
            break
        end
    end
end

entity.onMobDisengage = function(mob)
    mob:setMagicCastingEnabled(false)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local mobId = mob:getID()
        for i = 1, 2 do
            local petObj = GetMobByID(mobId + i)
            if petObj then
                petObj:setHP(0)
            end
        end
    end
end

return entity

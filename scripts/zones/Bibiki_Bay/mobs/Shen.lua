-----------------------------------
-- Area: Bibiki Bay
--  Mob: Shen
-----------------------------------
---@type TMobEntity
local entity = {}

local function enterShell(mob)
    mob:setAnimationSub(1)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setMod(xi.mod.UDMGPHYS, -8500)
    mob:setMod(xi.mod.UDMGRANGE, -8500)
    mob:setMod(xi.mod.UDMGMAGIC, -7500)
    mob:setMod(xi.mod.UDMGBREATH, -7500)
    mob:setMod(xi.mod.REGEN, 100)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 250)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setLocalVar('inShell', 1)
end

local function exitShell(mob)
    mob:setAnimationSub(0)
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.UDMGMAGIC, 0)
    mob:setMod(xi.mod.UDMGBREATH, 0)
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMobMod(xi.mobMod.SKILL_LIST, 251)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setLocalVar('inShell', 0)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.REQUIEM)
    mob:setMod(xi.mod.WATER_ABSORB, 100)

    mob:setLocalVar('shellTimer', os.time() + 60)
    mob:setLocalVar('petCooldown', os.time() + 20)
    exitShell(mob)

    mob:addListener('MAGIC_STATE_EXIT', 'SHEN_MAGIC_EXIT', function(shen, spell)
        if spell:getID() == xi.magic.spell.FLOOD then
            mob:setMagicCastingEnabled(true)
            -- need to remove chainspell manually so it can be done silently
            if mob:hasStatusEffect(xi.effect.CHAINSPELL) then
                mob:delStatusEffectSilent(xi.effect.CHAINSPELL)
            end
        end
    end)
end

entity.onMobFight = function(mob, target)
    -- check timer for going into or out of shell
    if os.time() > mob:getLocalVar('shellTimer') then
        if mob:getLocalVar('inShell') == 0 and mob:getAnimationSub() == 0 then
            enterShell(mob)
            mob:setLocalVar('shellTimer', os.time() + math.random(30, 100))
        elseif mob:getLocalVar('inShell') == 1 and mob:getAnimationSub() == 1 then
            exitShell(mob)
            mob:setLocalVar('shellTimer', os.time() + math.random(30, 100))
        end
    end

    local mobId = mob:getID()
    local petOne = GetMobByID(mobId + 1)
    local petTwo = GetMobByID(mobId + 2)
    local petCooldown = mob:getLocalVar('petCooldown')
    local mobAction = mob:getCurrentAction()
    local mobIsBusy = false

    -- TODO: Potentialy create a global function for this type of isBusy logic (for use in many mobs)
    if
        mobAction == xi.act.MOBABILITY_START or
        mobAction == xi.act.MOBABILITY_USING or
        mobAction == xi.act.MOBABILITY_INTERRUPT or
        mobAction == xi.act.MOBABILITY_FINISH or
        mobAction == xi.act.MAGIC_START or
        mobAction == xi.act.MAGIC_CASTING or
        mobAction == xi.act.MAGIC_INTERRUPT or
        mobAction == xi.act.MAGIC_FINISH or
        not mob:actionQueueEmpty()
    then
        mobIsBusy = true
    end

    -- Shen instant casts Flood to spawn a pet
    if
        os.time() >= petCooldown and
        petOne and
        petTwo and
        (not petOne:isSpawned() or not petTwo:isSpawned()) and
        not mobIsBusy
    then
        mob:setMagicCastingEnabled(false)
        mob:addStatusEffectEx(xi.effect.CHAINSPELL, xi.effect.CHAINSPELL, 1, 0, 3, true)
        mob:castSpell(xi.magic.spell.FLOOD, target)
        mob:setLocalVar('petCooldown', os.time() + 20)
    end

    -- Shen exits shell if a pet dies so that it can respawn it
    local petDeath = mob:getLocalVar('filtrateDeath')
    if petDeath == 1 then
        if mob:getLocalVar('inShell') == 1 and mob:getAnimationSub() == 1 then
            exitShell(mob)
            mob:setLocalVar('shellTimer', os.time() + math.random(30, 100))
        end

        mob:setLocalVar('filtrateDeath', 0)
    end

    -- every 30-90 seconds have one of the filtrates heal Shen via a water spell
    if os.time() > mob:getLocalVar('healTimer') then
        local pets = { petOne, petTwo }
        pets = utils.shuffle(pets)

        for _, shenFiltrate in ipairs(pets) do
            if
                shenFiltrate and
                shenFiltrate:isAlive() and
                shenFiltrate:checkDistance(mob) < 20
            then
                local spells = { xi.magic.spell.WATER_IV, xi.magic.spell.WATER_III }
                local spellID = spells[math.random(1, #spells)]
                shenFiltrate:castSpell(spellID, mob)
                mob:setLocalVar('healTimer', os.time() + math.random(40, 100))
                break
            end
        end
    end
end

entity.onSpellPrecast = function(mob, spell)
    local target = mob:getTarget()
    if not target then
        return
    end

    local pos = target:getPos()

    if spell:getID() == xi.magic.spell.FLOOD then
        for i = 1, 2 do
            local pet = GetMobByID(mob:getID() + i)
            if pet and not pet:isSpawned() then
                SpawnMob(pet:getID())
                pet:updateEnmity(target)
                pet:setPos(pos.x, pos.y, pos.z, pos.rot)
                break
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if mob:getLocalVar('firstOnMobDeathCall') == 0 then
        local mobId = mob:getID()
        for i = 1, 2 do
            local petObj = GetMobByID(mobId + i)
            if petObj then
                petObj:setHP(0)
            end
        end

        mob:setLocalVar('firstOnMobDeathCall', 1)
        mob:removeListener('SHEN_MAGIC_EXIT')
    end
end

return entity

-----------------------------------
-- Area: Bibiki Bay
--  Mob: Shen
-----------------------------------
require('scripts/globals/magic')
-----------------------------------
local entity = {}

-- TODO: Going into shell mechanic isn't 100% precise, could use more research

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
    mob:setLocalVar("inShell", 1)
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
    mob:setLocalVar("inShell", 0)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("shellTimer", os.time() + 90)
    mob:setLocalVar("petCooldown", os.time() + 20)
    exitShell(mob)

    mob:addListener("MAGIC_STATE_EXIT", "SHEN_MAGIC_EXIT", function(shen, spell)
        if spell:getID() == xi.magic.spell.FLOOD then
            mob:setMagicCastingEnabled(true)
        end
    end)
end

entity.onMobFight = function(mob, target)
    local timeToShell = mob:getLocalVar("shellTimer")
    -- time to consider entering shell
    if os.time() > timeToShell then
        -- if out of shell then can enter
        if mob:getLocalVar("inShell") == 0 and mob:getAnimationSub() == 0 then
            enterShell(mob)

            -- calculate how long to stay in shell and schedule when to exit shell
            local timeInShell = math.random(50, 70)
            mob:timer(timeInShell * 1000, function(shen)
                -- if still in shell after timer then can exit
                if shen:getLocalVar("inShell") == 1 and shen:getAnimationSub() == 1 then
                    exitShell(shen)
                    shen:setLocalVar("shellTimer", os.time() + 60)
                end
            end)
        end
    end

    -- Shen instant casts Flood to spawn a pet
    local mobId = mob:getID()
    local petOne = GetMobByID(mobId + 1)
    local petTwo = GetMobByID(mobId + 2)
    local petCooldown = mob:getLocalVar("petCooldown")

    if
        os.time() >= petCooldown and
        (not petOne:isSpawned() or not petTwo:isSpawned()) and
        mob:actionQueueEmpty()
    then
        mob:setMagicCastingEnabled(false)
        mob:addStatusEffect(xi.effect.CHAINSPELL, 1, 0, 2)
        mob:castSpell(xi.magic.spell.FLOOD, target)
        mob:setLocalVar("petCooldown", os.time() + 20)
    end

    -- Shen exits shell if a pet dies so that it can respawn it
    local petDeath = mob:getLocalVar("filtrateDeath")
    if petDeath == 1 then
        -- if in shell exit and reset timer for entering shell
        if mob:getLocalVar("inShell") == 1 and mob:getAnimationSub() == 1 then
            exitShell(mob)
            mob:setLocalVar("shellTimer", os.time() + 60)
        end

        mob:setLocalVar("filtrateDeath", 0)
    end
end

entity.onSpellPrecast = function(mob, spell)
    local target = mob:getTarget()
    local pos = target:getPos()

    if spell:getID() == 214 then
        for i = 1, 2 do
            local pet = GetMobByID(mob:getID() + i)
            if not pet:isSpawned() then
                SpawnMob(pet:getID()):updateEnmity(target)
                pet:setPos(pos.x, pos.y, pos.z, pos.rot)
                break
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        local mobId = mob:getID()
        for i = 1, 2 do
            local petID = GetMobByID(mobId + i)
            petID:setHP(0)
        end

        -- Save off quest marker local variable
        local qmVar = mob:getLocalVar("qm")
        -- Clear everything else
        mob:resetLocalVars()
        mob:setLocalVar("qm", qmVar)
        mob:removeListener("SHEN_MAGIC_EXIT")
    end
end

return entity

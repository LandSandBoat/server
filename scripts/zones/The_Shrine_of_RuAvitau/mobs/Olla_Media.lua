-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Olla Media
-----------------------------------
local ID = zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.REGAIN, 200)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.BIO_III,    target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,      3, 100 },
        [ 2] = { xi.magic.spell.SLEEPGA,    target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I,  1, 100 },
        [ 3] = { xi.magic.spell.SLEEPGA_II, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I,  2, 100 },
        [ 4] = { xi.magic.spell.STUN,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.STUN,     1, 100 },
        [ 5] = { xi.magic.spell.ABSORB_STR, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.STR_DOWN, 1, 100 },
        [ 6] = { xi.magic.spell.ABSORB_DEX, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DEX_DOWN, 1, 100 },
        [ 7] = { xi.magic.spell.ABSORB_VIT, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.VIT_DOWN, 1, 100 },
        [ 8] = { xi.magic.spell.ABSORB_AGI, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.AGI_DOWN, 1, 100 },
        [ 9] = { xi.magic.spell.ABSORB_INT, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.INT_DOWN, 1, 100 },
        [10] = { xi.magic.spell.ABSORB_MND, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.MND_DOWN, 1, 100 },
        [11] = { xi.magic.spell.ABSORB_CHR, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.CHR_DOWN, 1, 100 },
        [12] = { xi.magic.spell.DRAIN,      target, false, xi.action.type.DRAIN_HP,          nil,                0, 100 },
        [13] = { xi.magic.spell.ASPIR,      target, false, xi.action.type.DRAIN_MP,          nil,                0, 100 },
    }

    if
        target:hasStatusEffectByFlag(xi.effectFlag.DISPELABLE) and
        mob:isEngaged()
    then
        table.insert(spellList, #spellList + 1, { xi.magic.spell.DISPEL, target, false, xi.action.type.NONE, nil, 0, 100 })
    end

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 25,
        magicalElement = xi.element.DARK,
    }

    return xi.combat.action.executeAddEffectDispel(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local deathPosition = mob:getPos()
        local ollaGrande    = GetMobByID(mob:getID() + 1)

        if not ollaGrande then
            return
        end

        ollaGrande:setSpawn(deathPosition.x, deathPosition.y, deathPosition.z, deathPosition.rot)
        SpawnMob(ollaGrande:getID()):updateClaim(player)
    end
end

entity.onMobDespawn = function(mob)
    if not GetMobByID(mob:getID() + 1):isSpawned() then -- if this Media despawns and Grande is not alive, it would be because it despawned outside of being killed.
        GetNPCByID(ID.npc.OLLAS_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
    end
end

return entity

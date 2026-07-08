-----------------------------------
-- Area: Pso'Xja
--   NM: Golden-Tongued Culberry
-- !pos -288.126 32.066 260.040 9
-- To Do: Verify the supposed behavior that switching targets forcibly interrupts casting.
-----------------------------------
mixins = { require('scripts/mixins/families/tonberry') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 1) -- Minimum gap between casts (0 is invalid) so he casts near-constantly.
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1) -- His AoE spells hit all targets.
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addListener('ITEM_DROPS', 'ITEM_DROPS_CULBERRY', function(mobArg, loot)
        loot:addItemFixed(xi.item.UGGALEPIH_PENDANT, mob:getLocalVar('DropRate'))
    end)
end

entity.onMobSpawn = function(mob)
    mob:setAutoAttackEnabled(false)
    mob:setMobAbilityEnabled(false)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1) -- Disable the engine's wall-clipping chase; movement is driven by a navmesh-only script path in onMobFight.
    mob:setLocalVar('chasing', 0)
    mob:setMod(xi.mod.POWER_MULTIPLIER_SPELL, 25)
    mob:setMod(xi.mod.UFASTCAST, 0) -- He actually has no fastcast. He is just a chain caster. This is to revert his insta-death on pets.
end

entity.onMobFight = function(mob, target)
    -- Don't queue more actions (casts/paths) while he is already acting.
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Pet/Trust holding hate: force an instant Death cast.
    if target:isPet() then
        mob:setMod(xi.mod.UFASTCAST, 100)
        mob:castSpell(xi.magic.spell.DEATH, target)
        return
    end

    mob:setMod(xi.mod.UFASTCAST, 0) -- Revert fastcast for non-pet targets.

    -- Navmesh-only pursuit: start chasing past 18 yalms and keep closing in
    -- until within 17 yalms, so he doesn't jitter at the boundary. NO_MOVE disables the
    -- engine's wall-clipping fallback, so he can never walk off the map.
    local distance = mob:checkDistance(target)

    if distance > 18 then
        mob:setLocalVar('chasing', 1)
    elseif distance <= 17 then
        mob:setLocalVar('chasing', 0)
    end

    -- Cast whenever the target is within his 18-yalm casting range; while closing from
    -- farther out he holds fire. Disabling casting (rather than returning no spell) is what
    -- stops the default spell list's placeholder (Knight's Minne) from firing as a fallback.
    mob:setMagicCastingEnabled(distance <= 18)

    if mob:getLocalVar('chasing') == 1 then
        if not mob:isFollowingPath() then
            mob:pathTo(target:getXPos(), target:getYPos(), target:getZPos(), bit.bor(xi.pathflag.RUN, xi.pathflag.SCRIPT))
        end
    elseif mob:isFollowingPath() then
        mob:clearPath()
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.CURE_IV,      mob,    false, xi.action.type.HEALING_FORCE_SELF, 95,                  0, 100 },
        [ 2] = { xi.magic.spell.DRAIN,        target, false, xi.action.type.DRAIN_HP,           nil,                 0, 100 },
        [ 3] = { xi.magic.spell.SLEEPGA_II,   target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.SLEEP_I,   2, 100 },
        [ 4] = { xi.magic.spell.PARALYGA,     target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.PARALYSIS, 0, 100 },
        [ 5] = { xi.magic.spell.SILENCEGA,    target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.SILENCE,   0, 100 },
        [ 6] = { xi.magic.spell.FIRE_IV,      target, false, xi.action.type.DAMAGE_TARGET,      nil,                 0, 100 },
        [ 7] = { xi.magic.spell.BLIZZARD_IV,  target, false, xi.action.type.DAMAGE_TARGET,      nil,                 0, 100 },
        [ 8] = { xi.magic.spell.AERO_IV,      target, false, xi.action.type.DAMAGE_TARGET,      nil,                 0, 100 },
        [ 9] = { xi.magic.spell.STONE_IV,     target, false, xi.action.type.DAMAGE_TARGET,      nil,                 0, 100 },
        [10] = { xi.magic.spell.THUNDER_IV,   target, false, xi.action.type.DAMAGE_TARGET,      nil,                 0, 100 },
        [11] = { xi.magic.spell.WATER_IV,     target, false, xi.action.type.DAMAGE_TARGET,      nil,                 0, 100 },
        [12] = { xi.magic.spell.FIRAGA_III,   target, false, xi.action.type.DAMAGE_TARGET,      nil,                 0, 100 },
        [13] = { xi.magic.spell.BLIZZAGA_III, target, false, xi.action.type.DAMAGE_TARGET,      nil,                 0, 100 },
        [14] = { xi.magic.spell.AEROGA_III,   target, false, xi.action.type.DAMAGE_TARGET,      nil,                 0, 100 },
        [15] = { xi.magic.spell.STONEGA_III,  target, false, xi.action.type.DAMAGE_TARGET,      nil,                 0, 100 },
        [16] = { xi.magic.spell.THUNDAGA_III, target, false, xi.action.type.DAMAGE_TARGET,      nil,                 0, 100 },
        [17] = { xi.magic.spell.WATERGA_III,  target, false, xi.action.type.DAMAGE_TARGET,      nil,                 0, 100 },
        [18] = { xi.magic.spell.DEATH,        target, false, xi.action.type.DAMAGE_TARGET,      nil,                 0, 400 },
    }

    -- Drop any spell still on cooldown so a pick is never wasted on an unavailable
    -- spell; combined with the minimal MAGIC_COOL this keeps him casting constantly.
    local ready = {}
    for _, row in ipairs(spellList) do
        if not mob:hasRecast(xi.recast.MAGIC, row[1]) then
            ready[#ready + 1] = row
        end
    end

    return xi.combat.behavior.chooseAction(mob, target, nil, #ready > 0 and ready or spellList)
end

return entity

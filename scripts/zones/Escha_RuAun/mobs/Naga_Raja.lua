-----------------------------------
-- Area: Escha - Ru'Aun
--  Mob: Naga Raja
-----------------------------------
mixins = { require('scripts/mixins/draw_in') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setPriorityRender(true)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 500) -- Remove this line once Naga has been properly captured

    mob:setLocalVar('[2hour]HPP', math.randomInt(20, 65))
    mob:setLocalVar('[2hour]Used', 0)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    if mob:getLocalVar('[2hour]Used') ~= 0 then
        return
    end

    if mob:getHPP() >= mob:getLocalVar('[2hour]HPP') then
        return
    end

    mob:setLocalVar('[2hour]Used', 1)
    mob:useMobAbility(xi.mobSkill.HUNDRED_FISTS_1)
end

entity.onMobSpellChoose = function(mob, target, spell)
    local spellList =
    {
        [ 1] = { xi.magic.spell.ICE_SPIKES,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ICE_SPIKES, 0, 100 },
        [ 2] = { xi.magic.spell.BLIZZARD_VI,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [ 3] = { xi.magic.spell.WATER_VI,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [ 4] = { xi.magic.spell.BLIZZAGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [ 5] = { xi.magic.spell.BLIZZAJA,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [ 6] = { xi.magic.spell.WATERGA_III,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [ 7] = { xi.magic.spell.WATERJA,      target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [ 8] = { xi.magic.spell.PARALYGA,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.PARALYSIS,  0, 100 },
        [ 9] = { xi.magic.spell.DISPELGA,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [10] = { xi.magic.spell.BINDGA,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIND,       0, 100 },
        [11] = { xi.magic.spell.SILENCEGA,    target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SILENCE,    0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.NAGA_RAJA_NULLIFIER)
    end

    -- TODO: Process DI completion, award points, tear down fence etc
end

return entity

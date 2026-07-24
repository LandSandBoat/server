-----------------------------------
-- Area: QuBia_Arena
--  Mob: Death Clan Destroyer
-----------------------------------
local ID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 60)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 40) -- 20-40s between casts; captured Curaga II gaps were 34s and 39s.
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 100)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- The other first-wave orcs are eligible targets for its healing.
    local allies = {}
    local offset = ID.mob.WARLORD_ROJGNOJ + (battlefield:getArea() - 1) * 14

    for allyId = offset + 3, offset + 12 do
        local allyMob = GetMobByID(allyId)
        if allyMob and allyMob:isSpawned() then
            table.insert(allies, allyMob)
        end
    end

    local spellList =
    {
        [1] = { xi.magic.spell.CURAGA_II, mob, true, xi.action.type.HEALING_FORCE_SELF, 95, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, allies, spellList)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    if GetSystemTime() < mob:getLocalVar('[curaga]cooldown') then
        return
    end

    -- Wake sleeping allies with Curaga II.
    local instOffset = ID.mob.WARLORD_ROJGNOJ + (mob:getBattlefield():getArea() - 1) * 14
    for allyId = instOffset + 3, instOffset + 12 do
        local allyMob = GetMobByID(allyId)
        if allyMob and allyMob:hasStatusEffect(xi.effect.SLEEP_I) then
            -- Mobs cannot target each other with party-flagged spells, so self-cast and let the AoE wake them.
            mob:castSpell(xi.magic.spell.CURAGA_II, mob)
            mob:setLocalVar('[curaga]cooldown', GetSystemTime() + 8)
            break
        end
    end
end

return entity

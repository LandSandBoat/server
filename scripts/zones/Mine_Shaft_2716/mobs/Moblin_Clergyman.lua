-----------------------------------
-- Area: Mine Shaft 2716
-- Return to the Depths: Bastok Quest: 1 79
-- NM: Twilotak
-----------------------------------
---@type TMobEntity
local entity = {}

local ID = zones[xi.zone.MINE_SHAFT_2716]

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.SILENCE)

    mob:addListener('MAGIC_STATE_EXIT', 'MAGIC_EMOTE', function(mobArg, spell)
        mobArg:useMobAbility(xi.mobSkill.MOBLIN_EMOTE_3)
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 180)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setMobAbilityEnabled(false)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
end

entity.onMobEngage = function(mob, target)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, math.randomInt(60, 180))
    mob:setMagicCastingEnabled(true)
end

entity.onMobSpellChoose = function(mob, target, spell)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return 0
    end

    local twilotak = GetMobByID(ID.mob.TWILOTAK + (battlefield:getArea() - 1) * 7)
    local spellList =
    {
        xi.magic.spell.CURE_IV,
        xi.magic.spell.HOLY,
    }

    if
        twilotak and
        not twilotak:hasStatusEffect(xi.effect.PROTECT)
    then
        table.insert(spellList, xi.magic.spell.PROTECT_III)
    end

    local spellId = spellList[math.randomInt(1, #spellList)]
    if
        spellId == xi.magic.spell.CURE_IV or
        spellId == xi.magic.spell.PROTECT_III
    then
        return spellId, twilotak
    end

    local nearbyPlayers = {}
    for _, player in pairs(battlefield:getPlayers()) do
        if
            player and
            mob:checkDistance(player) <= 21
        then
            table.insert(nearbyPlayers, player)
        end
    end

    if #nearbyPlayers == 0 then
        return 0
    end

    return spellId, nearbyPlayers[math.randomInt(1, #nearbyPlayers)]
end

return entity

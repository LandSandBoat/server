-----------------------------------
-- Area: Balgas Dais
--  Mob: Macan Gadangan
-- BCNM: Wild Wild Whiskers
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------
---@type TMobEntity
local entity = {}

-- Phase table : data = { [1] HP Percent, [2] Spell Multiplier, [3] Magic Cooldown, [4] Spell, [5] Message }
local phaseTable =
{
    [1] = { 80,   0, 20, xi.magic.spell.THUNDER,     balgasID.text.WILD_WILD_WHISKERS_OFFSET     }, -- Slightly...
    [2] = { 60,  10, 20, xi.magic.spell.THUNDER_II,  balgasID.text.WILD_WILD_WHISKERS_OFFSET + 1 }, -- Rapidly...
    [3] = { 40,  30, 25, xi.magic.spell.THUNDAGA,    balgasID.text.WILD_WILD_WHISKERS_OFFSET + 2 }, -- Wildly...
    [4] = { 20,  50, 30, xi.magic.spell.THUNDAGA_II, balgasID.text.WILD_WILD_WHISKERS_OFFSET + 3 }, -- Violently...
    [5] = {  0,  70, 90, xi.magic.spell.BURST,       balgasID.text.WILD_WILD_WHISKERS_OFFSET + 4 }, -- Uncontrollably!
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMod(xi.mod.REGAIN, 50)
    mob:setMod(xi.mod.REFRESH, 50) -- Seems to be able to cast spells infinitely, either has strong refresh or ludicrous MP pool
    mob:setMod(xi.mod.DOUBLE_ATTACK, 30)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('hasBeenSilenced', 0)
end

-- Check to see if I have been Silenced at any point during the fight
entity.onMobFight = function(mob, target)
    if mob:hasStatusEffect(xi.effect.SILENCE) then
        mob:setLocalVar('hasBeenSilenced', 1)
    end
end

-- We only use Frenzied Rage if our spells are interrupted
entity.onMobMobskillChoose = function(mob, target)
    local mobskillList =
    {
        xi.mobSkill.CHARGED_WHISKER,
        xi.mobSkill.CHAOTIC_EYE_1,
        xi.mobSkill.PETRIFACTIVE_BREATH,
    }

    return mobskillList[math.random(1, #mobskillList)]
end

-- Choose spell based on current phase or default to phase 5 (Burst) if I have been Silenced
entity.onMobSpellChoose = function(mob, target, spellId)
    local phase = 5

    if mob:getLocalVar('hasBeenSilenced') == 0 then
        for i = 1, #phaseTable do
            if mob:getHPP() >= phaseTable[i][1] then
                phase = i
                break
            end
        end
    end

    mob:setMod(xi.mod.POWER_MULTIPLIER_SPELL, phaseTable[phase][2]) -- Set spell damage multiplier for this phase
    mob:setMobMod(xi.mobMod.MAGIC_COOL, phaseTable[phase][3])       -- Set magic cooldown for this phase

    local battlefield = mob:getBattlefield()
    if battlefield then
        local players = battlefield:getPlayers()
        for _, player in pairs(players) do
            if player:isAlive() and mob:checkDistance(player) <= 30 then
                player:messageSpecial(phaseTable[phase][5]) -- Display message for this phase
            end
        end
    end

    return phaseTable[phase][4] -- Return spell for this phase
end

-- If any of my spells are interrupted, use Frenzied Rage
entity.onSpellInterrupted = function(mob, spell)
    mob:useMobAbility(xi.mobSkill.FRENZIED_RAGE_1)
end

return entity

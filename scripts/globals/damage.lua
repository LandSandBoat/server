-----------------------------------------------
-- Global Damage Taken Calculation
-----------------------------------------------
require("scripts/globals/status")

xi = xi or {}
xi.damage = {} or xi.damage

local attMods =
{
    [xi.attackType.PHYSICAL] =
    {
        { mod = xi.mod.DMGPHYS, min = -0.5, max = 1000 },
        { mod = xi.mod.DMGPHYS_II, min = -0.5, max = 1000 },
        { mod = xi.mod.UDMGPHYS },
        { mod = xi.mod.DMG },
    },
    [xi.attackType.MAGICAL] =
    {
        { mod = xi.mod.DMGMAGIC, min = -0.5, max = 1000 },
        { mod = xi.mod.DMGMAGIC_II, min = -0.5, max = 1000 },
        { mod = xi.mod.UDMGMAGIC },
        { mod = xi.mod.DMG },
    },
    [xi.attackType.BREATH] =
    {
        { mod = xi.mod.DMGBREATH, min = -0.5, max = 1000 },
        { mod = xi.mod.UDMGBREATH },
        { mod = xi.mod.DMG },
    },
    [xi.attackType.RANGED] =
    {
        { mod = xi.mod.DMGRANGE, min = -0.5, max = 1000 },
        { mod = xi.mod.UDMGRANGE },
        { mod = xi.mod.DMG },
    },
    [xi.attackType.SPECIAL] =
    {
        { mod = xi.mod.DMG },
    },
    [xi.attackType.NONE] =
    {
        { mod = xi.mod.DMG },
    },
}

local dmgMods =
{
    [xi.damageType.NONE] = xi.mod.NONE,
    [xi.damageType.ELEMENTAL] = xi.mod.NONE,
    [xi.damageType.PIERCING] = xi.mod.PIERCE_SDT,
    [xi.damageType.SLASHING] = xi.mod.SLASH_SDT,
    [xi.damageType.BLUNT] = xi.mod.IMPACT_SDT,
    [xi.damageType.HTH] = xi.mod.HTH_SDT,
    [xi.damageType.FIRE] = xi.mod.FIRE_SDT,
    [xi.damageType.ICE] = xi.mod.ICE_SDT,
    [xi.damageType.WIND] = xi.mod.WIND_SDT,
    [xi.damageType.EARTH] = xi.mod.EARTH_SDT,
    [xi.damageType.LIGHTNING] = xi.mod.THUNDER_SDT,
    [xi.damageType.WATER] = xi.mod.WATER_SDT,
    [xi.damageType.LIGHT] = xi.mod.LIGHT_SDT,
    [xi.damageType.DARK] = xi.mod.DARK_SDT,
}

xi.damage.returnDamageTakenMod = function(target, attackType, damageType)
    local dmgTakenMod = 1

    for _, mod in pairs(attMods[attackType]) do
        if mod.min ~= nil then
            dmgTakenMod = dmgTakenMod * (1 + utils.clamp(target:getMod(mod.mod) / 10000, mod.min, mod.max))
        else
            dmgTakenMod = dmgTakenMod * (1 + (target:getMod(mod.mod) / 10000))
        end
    end

    -- This is for PIERCE_SDT, SLASH_SDT, IMPACT_SDT, HTH_SDT
    -- All players and mobs have base of 1000
    if
        damageType and
        dmgMods[damageType] <= xi.mod.HTH_SDT and
        dmgMods[damageType] >= xi.mod.SLASH_SDT
    then
        dmgTakenMod = dmgTakenMod * ((target:getMod(dmgMods[damageType])) / 1000)
    elseif damageType and dmgMods[damageType] then -- This is for elemental SDTs only
        -- Magic SDT range from -10000 to 10000
        -- Positive numbers mean less damage taken. Negative mean more damage taken.
        -- Example: a value of 5000 -> 50% LESS damage taken.
        dmgTakenMod = dmgTakenMod * (1 - target:getMod(dmgMods[damageType]) / 10000)
    end

    return dmgTakenMod
end

xi.damage.applyDamageTaken = function(target, dmg, attackType, damageType)
    return math.floor(dmg * xi.damage.returnDamageTakenMod(target, attackType, damageType))
end

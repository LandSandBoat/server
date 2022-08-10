-----------------------------------------------
-- Global Damage Taken Calculation
-----------------------------------------------
require("scripts/globals/status")

xi = xi or {}
xi.damage = {} or xi.damage

local dmgMods =
{
    [xi.attackType.PHYSICAL] =
    {
        {mod = xi.mod.DMGPHYS, min = -0.5, max = 1000},
        {mod = xi.mod.DMGPHYS_II, min = -0.5, max = 1000},
        {mod = xi.mod.UDMGPHYS},
        {mod = xi.mod.DMG},
    },
    [xi.attackType.MAGICAL] =
    {
        {mod = xi.mod.DMGMAGIC, min = -0.5, max = 1000},
        {mod = xi.mod.DMGMAGIC_II, min = -0.5, max = 1000},
        {mod = xi.mod.UDMGMAGIC},
        {mod = xi.mod.DMG},
    },
    [xi.attackType.BREATH] =
    {
        {mod = xi.mod.DMGBREATH, min = -0.5, max = 1000},
        {mod = xi.mod.UDMGBREATH},
        {mod = xi.mod.DMG},
    },
    [xi.attackType.RANGED] =
    {
        {mod = xi.mod.DMGRANGE, min = -0.5, max = 1000},
        {mod = xi.mod.UDMGRANGE},
        {mod = xi.mod.DMG},
    },
    [xi.attackType.SPECIAL] =
    {
        {mod = xi.mod.DMG},
    },
    [xi.attackType.NONE] =
    {
        {mod = xi.mod.DMG},
    },
}

xi.damage.applyDamageTaken = function(target, dmg, attackType)
    local dmgTakenMod = 0

    for _, mod in pairs(dmgMods[attackType]) do
        if mod.min ~= nil then
            dmgTakenMod = dmgTakenMod + utils.clamp(target:getMod(mod.mod) / 10000, mod.min, mod.max)
        else
            dmgTakenMod = dmgTakenMod + (target:getMod(mod.mod) / 10000)
        end
    end

    dmgTakenMod = utils.clamp(dmgTakenMod, -1, 1000)

    return utils.clamp(dmg * (1 + dmgTakenMod), 0, 99999)
end

xi.damage.returnDamageTakenMod = function(target, attackType)
    local dmgTakenMod = 0

    for _, mod in pairs(dmgMods[attackType]) do
        if mod.min ~= nil then
            dmgTakenMod = dmgTakenMod + utils.clamp(target:getMod(mod.mod) / 10000, mod.min, mod.max)
        else
            dmgTakenMod = dmgTakenMod + (target:getMod(mod.mod) / 10000)
        end
    end

    return utils.clamp(dmgTakenMod, -1, 1000) + 1
end

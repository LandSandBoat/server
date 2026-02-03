xi = xi or {}
xi.magicburst = xi.magicburst or {}

local matches =
{
-- [element Id] = { resonance Id }
--    1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17
--    N  T  C  L  S  R  D  I  I  G  D  F  F  L  D  L  D
    [xi.element.NONE   ] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    [xi.element.FIRE   ] = { 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0 },
    [xi.element.ICE    ] = { 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1 },
    [xi.element.WIND   ] = { 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0 },
    [xi.element.EARTH  ] = { 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1 },
    [xi.element.THUNDER] = { 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0 },
    [xi.element.WATER  ] = { 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1 },
    [xi.element.LIGHT  ] = { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0 },
    [xi.element.DARK   ] = { 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1 },
}

---@param target CBaseEntity
---@param actionElement number
---@return number, number
xi.magicburst.formMagicBurst = function(target, actionElement)
    if not target then
        return 0, 0
    end

    if not actionElement then
        return 0, 0
    end

    if actionElement <= xi.element.NONE or actionElement > xi.element.DARK then
        return 0, 0
    end

    local resonance = target:getStatusEffect(xi.effect.SKILLCHAIN)
    if not resonance then
        return 0, 0
    end

    local resonanceTier = resonance:getTier()
    if resonanceTier <= 0 then
        return 0, 0
    end

    local isMatch = matches[actionElement][resonance:getPower() + 1] > 0 and true or false
    if not isMatch then
        return 0, 0
    end

    return resonanceTier, resonance:getSubPower()
end

-- Returns a boolean if the element matches the skillchain property given
xi.magicburst.doesElementMatchWeaponskill = function(actionElement, SCProp)
    return matches[actionElement][SCProp + 1] > 0 and true or false
end

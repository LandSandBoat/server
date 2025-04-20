xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.utils = xi.combat.utils or {}

xi.combat.utils.getScaledItemModifier = function(entity, item, mod)
    local reqLevel = item:getReqLvl()
    if entity:GetMLevel() < reqLevel then
        local modAmount = item:getModifier(mod)

        if mod == xi.mod.RANGED_DMG_RATING then
            modAmount = modAmount * 3
            modAmount = math.floor(modAmount / 4)
        elseif mod == xi.mod.MP then
            modAmount = math.floor(modAmount / 2)
        elseif mod == xi.mod.MACC then
            modAmount = math.floor(modAmount / 3)
        end
        
        return math.floor(modAmount / reqLevel)
    else
        return item.getMod(mod)
    end

    return 0
end

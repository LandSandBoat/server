function updateModPerformance(pet, mod, key, value, cap)
    local previous = pet:getLocalVar(key)
    if previous ~= 0 then
        pet:delMod(mod, previous)
    end
    value = value + value * (pet:getMod(xi.mod.AUTO_PERFORMANCE_BOOST) / 100)
    if cap then
        value = math.min(value, cap)
    end
    pet:addMod(mod, value)
    pet:setLocalVar(key, value)
end

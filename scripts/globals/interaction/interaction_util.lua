interactionUtil = interactionUtil or {}

-- Makes a table that returns the value of the provided getter function when it is given the key as an argument,
-- and it caches this result, such that the getter function is only called once per key.
function interactionUtil.makeTableCache(getterFunc)
    local obj = {}
    obj.cache = {}
    local mt = {
        __index = function(table, key)
            if obj.cache[key] == nil then
                obj.cache[key] = getterFunc(key)
            end
            return obj.cache[key]
        end
    }
    setmetatable(obj, mt)
    return obj
end

-- Makes a nested cache with the a handler container being the first level, and a variable name for the second level.
-- This is done to avoid fetching the same variables from char_vars multiple times during the same NPC interaction
function interactionUtil.makeContainerVarCache(player)
    return interactionUtil.makeTableCache(function (container)
        return interactionUtil.makeTableCache(function (varname)
            return container:getVar(player, varname)
        end)
    end)
end

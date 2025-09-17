-----------------------------------
-- func: inherit
-- desc:
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = '',
}

commandObj.onTrigger = function(player)
    -- Just to prove we can take a CCharEntity directly
    local p = GetPlayerByName(player:getName())
    if p then
        -- We can still use CLuaBaseEntity bindings
        p:setLocalVar('hi', 42)
        -- But we can also use CLuaCharEntity bindings!
        p:addExp(500)
    end

    -- Miladi-Nildi in Lower Jeuno
    -- This is going to be a CLuaBaseEntity
    local n = GetNPCByID(17780856)
    if n then
        -- CLuaBaseEntity bindings are obviously supported
        n:setLocalVar('hi', 24)

        -- But CLuaCharEntity bindings are not supported
        -- n:addExp(500) -- 'attempt to call method 'addExp' (a nil value)'

        -- We can also rely on the strong typing for parameters
        -- This binding only accepts a CLuaCharEntity parameter
        n:doesSomething(p) -- This works!
        -- n:doesSomething(n) -- 'error: stack index 2, expected userdata, received sol.CLuaBaseEntity: value at this index does not properly reflect the desired type (bad argument into 'void(CLuaCharEntity*)')'
    end
end

return commandObj

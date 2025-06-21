local outputHandlers =
{
    ['term'] =
    {
        name = 'gtest',
        args =
        {
            [1] = '--color',
        },
    },
    ['junit'] =
    {
        name = 'junit',
        args =
        {
            [1] = 'xi_test.xml',
        },
    },
    ['json'] =
    {
        name = 'json',
        args = {},
    },
}

---@param handlerName 'term' | 'junit' | 'json'
---@param verbose boolean
return function(busted, handlerName, verbose)
    local outputHandlerLoader = require 'busted.modules.output_handler_loader' ()

    -- Set up output handler to listen to events
    outputHandlerLoader(busted, outputHandlers[handlerName].name,
        {
            defaultOutput   = 'plainTerminal',
            enableSound     = false,
            verbose         = verbose,
            suppressPending = false,
            language        = 'en',
            deferPrint      = false,
            arguments       = outputHandlers[handlerName].args,
        })
end

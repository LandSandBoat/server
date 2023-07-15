-----------------------------------
-- Fellow Utils (Used by fellows and scripts who trigger fellow related CSs)
-----------------------------------
require("scripts/globals/utils")
-----------------------------------
xi = xi or {}
xi.fellow_utils = {}

xi.fellow_utils.getStyleParam = function(player)
    local body       = player:getFellowValue("body")
    local hands      = player:getFellowValue("hands")
    local legs       = player:getFellowValue("legs")
    local feet       = player:getFellowValue("feet")
    local styleParam = bit.lshift(math.floor(feet / 100), 12) +
                        bit.lshift(math.floor(legs / 100) * 4, 8) +
                        bit.lshift(math.floor(hands / 100), 8) +
                        bit.lshift(math.floor(body / 100) * 4, 4)
    return styleParam
end

xi.fellow_utils.getLookParam = function(player)
    local body      = player:getFellowValue("body")
    local hands     = player:getFellowValue("hands")
    local legs      = player:getFellowValue("legs")
    local feet      = player:getFellowValue("feet")
    local lookParam = bit.lshift(feet % 100, 16) +
                        bit.lshift(legs % 100, 12) +
                        bit.lshift(hands % 100, 8) +
                        bit.lshift(body % 100, 4) +
                        player:getFellowValue("head")
    return lookParam
end

xi.fellow_utils.getFellowParam = function(player)
    local fellowParam = bit.lshift(player:getFellowValue("face"), 20) +
                        bit.lshift(player:getFellowValue("size"), 16) +
                        bit.lshift(player:getFellowValue("personality"), 8) +
                        player:getFellowValue("fellowid")
    return fellowParam
end

xi.fellow_utils.checkPersonality = function(mob)
    local master = mob:getMaster()
    if master == nil then
        return
    end

    local personality   = master:getFellowValue("personality")

    switch (personality) : caseof
    {
        [4]  = function(x)
            personality = 0
        end,

        [8]  = function(x)
            personality = 1
        end,

        [12] = function(x)
            personality = 2
        end,

        [16] = function(x)
            personality = 3
        end,

        [40] = function(x)
            personality = 4
        end,

        [44] = function(x)
            personality = 5
        end,

        [20] = function(x)
            personality = 7
        end,

        [24] = function(x)
            personality = 8
        end,

        [28] = function(x)
            personality = 9
        end,

        [32] = function(x)
            personality = 10
        end,

        [36] = function(x)
            personality = 11
        end,

        [48] = function(x)
            personality = 12
        end,
    }

    return personality
end

-----------------------------------
-- HiddenQuest class
-----------------------------------
require('scripts/globals/interaction/container')
-----------------------------------

HiddenQuest = setmetatable({ area = {} }, { __index = Container })
HiddenQuest.__index = HiddenQuest
HiddenQuest.__eq = function(q1, q2)
    return q1.name == q2.name
end

HiddenQuest.reward = {}

function HiddenQuest:new(name)
    local obj = Container:new('HQuest[' .. name .. ']')
    setmetatable(obj, self)

    obj.name = name
    return obj
end

-----------------------------------
-- HiddenQuest operations
-----------------------------------

function HiddenQuest:complete(player)
    local gaveReward = npcUtil.giveReward(player, self.reward)
    if gaveReward then
        self:cleanup(player)
    end
    return gaveReward
end

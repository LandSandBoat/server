-----------------------------------
-- Area: Rala Waterways [U]
-----------------------------------
local entity = {}

-- [4] =
-- {
--     [47]   = { ['name']='Protect V',                      ['category']=4,  ['id']=47,   ['animation']=47,   ['message']=230, },
--     [52]   = { ['name']='Shell V',                        ['category']=4,  ['id']=52,   ['animation']=52,   ['message']=230, },
--     [54]   = { ['name']='Stoneskin',                      ['category']=4,  ['id']=54,   ['animation']=54,   ['message']=230, },
--     [56]   = { ['name']='Slow',                           ['category']=4,  ['id']=56,   ['animation']=56,   ['message']=236, },
--     [57]   = { ['name']='Haste',                          ['category']=4,  ['id']=57,   ['animation']=57,   ['message']=75,  },
--     [58]   = { ['name']='Paralyze',                       ['category']=4,  ['id']=58,   ['animation']=58,   ['message']=236, },
--     [216]  = { ['name']='Gravity',                        ['category']=4,  ['id']=216,  ['animation']=216,  ['message']=236, },
--     [286]  = { ['name']='Addle',                          ['category']=4,  ['id']=286,  ['animation']=119,  ['message']=236, },
-- },
--
-- [11] =
-- {
--     [3053] = { ['name']='Dynastic Gravitas',              ['category']=11, ['id']=3053, ['animation']=2232, ['message']=188, },
--     [3115] = { ['name']='Bellatrix of Light',             ['category']=11, ['id']=3115, ['animation']=2253, ['message']=101, },
--     [3116] = { ['name']='Bellatrix of Shadows',           ['category']=11, ['id']=3116, ['animation']=2254, ['message']=101, },
--     [3117] = { ['name']='',                               ['category']=11, ['id']=3117, ['animation']=2247, ['message']=1,   },
--     [3118] = { ['name']='',                               ['category']=11, ['id']=3118, ['animation']=2248, ['message']=1,   },
--     [3119] = { ['name']='',                               ['category']=11, ['id']=3119, ['animation']=2249, ['message']=1,   },
--     [3120] = { ['name']='',                               ['category']=11, ['id']=3120, ['animation']=2250, ['message']=1,   },
--     [3121] = { ['name']='',                               ['category']=11, ['id']=3121, ['animation']=2251, ['message']=1,   },
--     [3122] = { ['name']='',                               ['category']=11, ['id']=3122, ['animation']=2252, ['message']=1,   },
-- },

entity.onMobDeath = function(mob, player, optParams)
    local instance = mob:getInstance()
    instance:fail()
end

return entity

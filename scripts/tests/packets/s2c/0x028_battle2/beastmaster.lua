local ph      = require('scripts.tests.packets.s2c.0x028_battle2.placeholders')

---@type table<string, Battle2TestEntry>
local packets =
{
    ['Jug Pet Ready'] =
    {
        test = function(player, mob)
            stub('xi.mobskills.mobPhysicalMove', { dmg = 1, hitslanded = 1, isCritical = false })
            local pmob = player.entities:moveTo('Giant_Hunter')
            player:changeJob(xi.job.BST)
            player:spawnPet(xi.petId.COLDBLOOD_COMO)
            local pet = player:getPet()
            assert(pet)
            pet:engage(pmob:getTargID())
            xi.test.world:tickEntity(pet)
            xi.test.world:skipTime(5)
            player.actions:useAbility(player, xi.jobAbility.TAIL_BLOW)
            xi.test.world:skipTime(5)
            xi.test.world:tickEntity(pmob)
            xi.test.world:skipTime(5)
        end,

        expected =
        {
            {
                m_uID   = ph.TEST_CHAR,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.JOBABILITY_FINISH,
                cmd_arg = xi.jobAbility.TAIL_BLOW,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.TEST_CHAR,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 2,
                                sub_kind  = 94,
                                info      = 0,
                                scale     = 0,
                                value     = 0,
                                message   = 0,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.WEAPONSKILL_START,
                cmd_arg = xi.action.fourCC.SKILL_USE,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.IGNORE,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 0,
                                sub_kind  = 0,
                                info      = 0,
                                scale     = 0,
                                value     = 3851,
                                message   = xi.msg.basic.READIES_SKILL,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
            {
                m_uID   = ph.IGNORE,
                trg_sum = 1,
                res_sum = 0,
                cmd_no  = xi.action.category.MOBABILITY_FINISH,
                cmd_arg = 3851,
                info    = 0,
                target  =
                {
                    {
                        m_uID      = ph.IGNORE,
                        result_sum = 1,
                        result     =
                        {
                            {
                                miss      = 0,
                                kind      = 3,
                                sub_kind  = 110,
                                info      = ph.IGNORE,
                                scale     = ph.IGNORE,
                                value     = ph.IGNORE,
                                message   = xi.msg.basic.DAMAGE,
                                bit       = 0,
                                has_proc  = false,
                                has_react = false,
                            },
                        },
                    },
                },
            },
        },
    },
}

return packets

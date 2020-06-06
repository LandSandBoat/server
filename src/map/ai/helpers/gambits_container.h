#ifndef _GAMBITSCONTAINER
#define _GAMBITSCONTAINER

#include "../../../common/cbasetypes.h"
#include "../../entities/charentity.h"
#include "../../entities/trustentity.h"
#include "../ai_container.h"
#include "../controllers/trust_controller.h"
#include "../../mob_spell_container.h"
#include "../../status_effect.h"
#include "../../status_effect_container.h"

namespace gambits
{

enum class G_TARGET : uint16
{
    SELF   = 0,
    PARTY  = 1,
    TARGET = 2,
    MASTER = 3,
    TANK   = 4,
};

enum class G_CONDITION : uint16
{
    ALWAYS             = 0,
    HPP_LT             = 1,
    HPP_GTE            = 2,
    MPP_LT             = 3,
    TP_LT              = 4,
    TP_GTE             = 5,
    STATUS             = 6,
    NOT_STATUS         = 7,
    STATUS_FLAG        = 8,
    HAS_TOP_ENMITY     = 9,
    NOT_HAS_TOP_ENMITY = 10,
    SC_AVAILABLE       = 11,
    NOT_SC_AVAILABLE   = 12,
    MB_AVAILABLE       = 13,
};

enum class G_REACTION : uint16
{
    ATTACK = 0,
    ASSIST = 1,
    MA     = 2,
    JA     = 3,
    WS     = 4,
    MS     = 5,
};

enum class G_SELECT : uint16
{
    HIGHEST    = 0,
    LOWEST     = 1,
    SPECIFIC   = 2,
    RANDOM     = 3,
    MB_ELEMENT = 4,
};

struct Predicate_t
{
    G_TARGET target;
    G_CONDITION condition;
    uint16 condition_arg;
};

struct Action_t
{
    G_REACTION reaction;
    G_SELECT select;
    uint16 select_arg;
};

struct Gambit_t
{
    Predicate_t predicate;
    Action_t action;

    // TODO:
    //std::vector<Predicate_t> predicates;
    //std::vector<Action_t> actions;
    uint16 retry_delay;
    time_point last_used;
};

struct Chain_t
{
    std::vector<Gambit_t> gambits;
};

class CGambitsContainer
{
public:
    CGambitsContainer(CTrustEntity* trust) : POwner(trust) {}
    ~CGambitsContainer() = default;

    void AddGambit(Gambit_t gambit);
    void Tick(time_point tick);

private:
    CTrustEntity* POwner;
    time_point m_lastAction;
    std::vector<Gambit_t> gambits;
};

} // namespace gambits

#endif // _GAMBITSCONTAINER

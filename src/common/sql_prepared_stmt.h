#pragma once

#include <mysql.h>
#include <string>
#include <vector>

#include "sql.h"

class SqlPreparedStatement
{
public:
    SqlPreparedStatement(MYSQL* handle, std::string const& query);
    ~SqlPreparedStatement();

    void Execute();

private:
    MYSQL_STMT*             m_Statement;
    std::string             m_Query;
    std::vector<MYSQL_BIND> m_Fields;
    std::vector<MYSQL_BIND> m_Params;
};

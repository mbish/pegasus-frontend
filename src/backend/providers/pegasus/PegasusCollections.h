// Pegasus Frontend
// Copyright (C) 2017-2018  Mátyás Mustoha
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.


#pragma once

#include <QHash>
#include <QStringList>
#include <functional>

namespace model { class Game; }
namespace model { class Collection; }


namespace providers {
namespace pegasus {

enum class CollAttribType : unsigned char;

class PegasusCollections {
public:
    PegasusCollections();

    void find_in_dirs(const QStringList&,
                      QHash<QString, model::Game*>&,
                      QHash<QString, model::Collection*>&,
                      const std::function<void(int)>&) const;

private:
    const QHash<QString, CollAttribType> m_key_types;
};

} // namespace pegasus
} // namespace providers

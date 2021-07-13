/**
 *
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#pragma once

#include <string>
#include <memory>

#include "rocksdb/env_encryption.h"
#include "utils/crypto/EncryptionUtils.h"
#include "logging/Logger.h"
#include "utils/crypto/EncryptionManager.h"

namespace org {
namespace apache {
namespace nifi {
namespace minifi {
namespace core {
namespace repository {

struct DbEncryptionOptions {
  std::string database;
  std::string encryption_key_name;
};

std::shared_ptr<rocksdb::Env> createEncryptingEnv(const utils::crypto::EncryptionManager& manager, const DbEncryptionOptions& options);

struct EncryptionEq {
  bool operator()(const rocksdb::Env* lhs, const rocksdb::Env* rhs) const;
};

}  // namespace repository
}  // namespace core
}  // namespace minifi
}  // namespace nifi
}  // namespace apache
}  // namespace org

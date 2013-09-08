/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.cloudera.llama.am.server.thrift;

import com.cloudera.llama.am.impl.ParamChecker;

public class ExceptionUtils {
  
  public static Throwable getRootCause(Throwable ex, 
      Class<? extends Throwable> rootCauseClassIfPresent) {
    ParamChecker.notNull(ex, "ex");
    ParamChecker.notNull(rootCauseClassIfPresent, "rootCauseClassIfPresent");
    Throwable rootCause = null;
    while (rootCause == null && ex != null) {
      if (rootCauseClassIfPresent.isInstance(ex)) {
        rootCause = ex;
      } if (ex.getCause() == null) {
        rootCause = ex;
      } else {
        ex = ex.getCause();
      }
    }
    return rootCause;
  }
  
}

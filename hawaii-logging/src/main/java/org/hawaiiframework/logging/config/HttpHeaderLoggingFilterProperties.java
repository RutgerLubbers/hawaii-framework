/*
 * Copyright 2015-2018 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.hawaiiframework.logging.config;

/**
 * Extension of basic LoggingFilterProperties that also holds the name of a HTTP header
 * that the filter can use.
 *
 * @see org.hawaiiframework.logging.web.filter.KibanaLogFilter
 * @see org.hawaiiframework.logging.web.filter.RequestIdFilter
 * @see org.hawaiiframework.logging.web.filter.TransactionIdFilter
 *
 * @author Paul Klos
 * @author Wouter Eerdekens
 * @since 2.0.0
 */
public class HttpHeaderLoggingFilterProperties extends LoggingFilterProperties {

    private String httpHeader;

    public String getHttpHeader() {
        return httpHeader;
    }

    public void setHttpHeader(final String httpHeader) {
        this.httpHeader = httpHeader;
    }
}

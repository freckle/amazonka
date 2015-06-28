{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}

-- Module      : Network.AWS.CloudFormation.EstimateTemplateCost
-- Copyright   : (c) 2013-2015 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- | Returns the estimated monthly cost of a template. The return value is an
-- AWS Simple Monthly Calculator URL with a query string that describes the
-- resources required to run the template.
--
-- <http://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_EstimateTemplateCost.html>
module Network.AWS.CloudFormation.EstimateTemplateCost
    (
    -- * Request
      EstimateTemplateCost
    -- ** Request constructor
    , estimateTemplateCost
    -- ** Request lenses
    , etcParameters
    , etcTemplateBody
    , etcTemplateURL

    -- * Response
    , EstimateTemplateCostResponse
    -- ** Response constructor
    , estimateTemplateCostResponse
    -- ** Response lenses
    , etcrURL
    , etcrStatus
    ) where

import           Network.AWS.CloudFormation.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | /See:/ 'estimateTemplateCost' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'etcParameters'
--
-- * 'etcTemplateBody'
--
-- * 'etcTemplateURL'
data EstimateTemplateCost = EstimateTemplateCost'
    { _etcParameters   :: !(Maybe [Parameter])
    , _etcTemplateBody :: !(Maybe Text)
    , _etcTemplateURL  :: !(Maybe Text)
    } deriving (Eq,Read,Show)

-- | 'EstimateTemplateCost' smart constructor.
estimateTemplateCost :: EstimateTemplateCost
estimateTemplateCost =
    EstimateTemplateCost'
    { _etcParameters = Nothing
    , _etcTemplateBody = Nothing
    , _etcTemplateURL = Nothing
    }

-- | A list of @Parameter@ structures that specify input parameters.
etcParameters :: Lens' EstimateTemplateCost [Parameter]
etcParameters = lens _etcParameters (\ s a -> s{_etcParameters = a}) . _Default;

-- | Structure containing the template body with a minimum length of 1 byte
-- and a maximum length of 51,200 bytes. (For more information, go to
-- <http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html Template Anatomy>
-- in the AWS CloudFormation User Guide.)
--
-- Conditional: You must pass @TemplateBody@ or @TemplateURL@. If both are
-- passed, only @TemplateBody@ is used.
etcTemplateBody :: Lens' EstimateTemplateCost (Maybe Text)
etcTemplateBody = lens _etcTemplateBody (\ s a -> s{_etcTemplateBody = a});

-- | Location of file containing the template body. The URL must point to a
-- template located in an S3 bucket in the same region as the stack. For
-- more information, go to
-- <http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html Template Anatomy>
-- in the AWS CloudFormation User Guide.
--
-- Conditional: You must pass @TemplateURL@ or @TemplateBody@. If both are
-- passed, only @TemplateBody@ is used.
etcTemplateURL :: Lens' EstimateTemplateCost (Maybe Text)
etcTemplateURL = lens _etcTemplateURL (\ s a -> s{_etcTemplateURL = a});

instance AWSRequest EstimateTemplateCost where
        type Sv EstimateTemplateCost = CloudFormation
        type Rs EstimateTemplateCost =
             EstimateTemplateCostResponse
        request = post
        response
          = receiveXMLWrapper "EstimateTemplateCostResult"
              (\ s h x ->
                 EstimateTemplateCostResponse' <$>
                   (x .@? "Url") <*> (pure s))

instance ToHeaders EstimateTemplateCost where
        toHeaders = const mempty

instance ToPath EstimateTemplateCost where
        toPath = const "/"

instance ToQuery EstimateTemplateCost where
        toQuery EstimateTemplateCost'{..}
          = mconcat
              ["Action" =: ("EstimateTemplateCost" :: ByteString),
               "Version" =: ("2010-05-15" :: ByteString),
               "Parameters" =:
                 toQuery (toQueryList "member" <$> _etcParameters),
               "TemplateBody" =: _etcTemplateBody,
               "TemplateURL" =: _etcTemplateURL]

-- | The output for a EstimateTemplateCost action.
--
-- /See:/ 'estimateTemplateCostResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'etcrURL'
--
-- * 'etcrStatus'
data EstimateTemplateCostResponse = EstimateTemplateCostResponse'
    { _etcrURL    :: !(Maybe Text)
    , _etcrStatus :: !Status
    } deriving (Eq,Read,Show)

-- | 'EstimateTemplateCostResponse' smart constructor.
estimateTemplateCostResponse :: Status -> EstimateTemplateCostResponse
estimateTemplateCostResponse pStatus =
    EstimateTemplateCostResponse'
    { _etcrURL = Nothing
    , _etcrStatus = pStatus
    }

-- | An AWS Simple Monthly Calculator URL with a query string that describes
-- the resources required to run the template.
etcrURL :: Lens' EstimateTemplateCostResponse (Maybe Text)
etcrURL = lens _etcrURL (\ s a -> s{_etcrURL = a});

-- | FIXME: Undocumented member.
etcrStatus :: Lens' EstimateTemplateCostResponse Status
etcrStatus = lens _etcrStatus (\ s a -> s{_etcrStatus = a});
